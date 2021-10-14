package service

import (
	"context"
	"errors"
	"fmt"
	"io"

	hiit "github.com/isaiahwong/hiit/api"
	"github.com/isaiahwong/hiit/internal"
	"github.com/isaiahwong/hiit/model"
)

func (svc *Service) SubInvites(user *hiit.WorkoutUser, stream hiit.HIITService_SubInvitesServer) error {
	ctx, cancel := context.WithCancel(stream.Context())
	defer cancel()

	listen := make(chan *hiit.InviteWaitingRoomRequest)
	svc.users[user.GetId()] = listen

	fmt.Println(user.GetId(), user.GetName(), " joined")

	errCh := internal.NewErrorChannel()
	defer func() {
		errCh.Close()
		close(listen)
		delete(svc.pubsub, user.GetId())
	}()

	go func() {
		var req *hiit.InviteWaitingRoomRequest
		for {
			select {
			case <-ctx.Done():
				return
			case m, ok := <-listen:
				if !ok {
					return
				}
				req = m
			}
			if err := stream.Send(req); err != nil {
				errCh.C <- err
				return
			}
		}
	}()

	select {
	case err := <-errCh.C:
		if err != nil && err != io.EOF {
			svc.logger.Errorf("%v %v", err)
		}
	case <-ctx.Done():
		fmt.Println(user.GetId(), user.GetName(), " has left")
	}
	return nil
}

func (svc *Service) NotifyInvites(ctx context.Context, req *hiit.InviteWaitingRoomRequest) (*hiit.Empty, error) {
	// retreive listen channel
	listen := svc.users[req.GetTo().GetId()]
	if listen == nil {
		fmt.Println("User does not exists")
		return &hiit.Empty{}, nil
	}

	listen <- req

	return &hiit.Empty{}, nil
}

func (svc *Service) StartWaitingRoom(ctx context.Context, req *hiit.StartWaitingRoomRequest) (*hiit.Empty, error) {
	host := req.GetHost()
	workout := req.GetWorkout()

	waitingRoom := svc.waitingRooms[workout]
	if waitingRoom == nil {
		return nil, errors.New("Waiting Room does not exist")
	}

	if waitingRoom.Host.Id != host.Id {
		return nil, errors.New("Invalid host")
	}

	waitingRoom.Start <- host.Id
	return &hiit.Empty{}, nil
}

func (svc *Service) CreateWaitingRoom(req *hiit.CreateWaitingRoomRequest, stream hiit.HIITService_CreateWaitingRoomServer) error {
	ctx, cancel := context.WithCancel(stream.Context())
	defer cancel()

	workout := req.GetWorkout()
	host := req.GetHost()

	waitingRoom := &model.WaitingRoom{
		Host:    host,
		Workout: workout,
		JoinSub: make(chan *model.WaitingSub),
		Start:   make(chan string),
		Users:   make(map[string]*model.WaitingSub),
	}

	fmt.Println(host.GetName(), "created room")

	svc.waitingRooms[workout] = waitingRoom

	errCh := internal.NewErrorChannel()
	defer func() {
		errCh.Close()
		close(waitingRoom.JoinSub)
		close(waitingRoom.Start)
		delete(svc.waitingRooms, workout)
	}()

	go func() {
		var err error
		for {
			select {
			case <-ctx.Done():
				return
			case userSub, ok := <-waitingRoom.JoinSub:
				fmt.Println("user joined")
				if !ok {
					return
				}
				err = svc.notifyWaiting(userSub, waitingRoom, stream)
			case start, ok := <-waitingRoom.Start:
				if !ok {
					return
				}
				// if start is not initiated by host, we ignore
				if start != waitingRoom.Host.Id {
					continue
				}

				// start logic
				for _, user := range waitingRoom.Users {
					user.Listen <- &hiit.WaitingRoomResponse{
						Host:  waitingRoom.Host,
						Users: waitingRoom.GetUsers(),
						Start: true,
					}
				}
				// kill channel
				errCh.C <- io.EOF
				return
			}

			if err != nil {
				errCh.C <- err
				return
			}
		}
	}()

	select {
	case err := <-errCh.C:
		if err != nil && err != io.EOF {
			svc.logger.Errorf("%v %v", err)
		}
	case <-ctx.Done():
		fmt.Println("end")
	}
	fmt.Println("waiting room closed")
	return nil
}

func (svc *Service) notifyWaiting(userSub *model.WaitingSub, waitingRoom *model.WaitingRoom, stream hiit.HIITService_CreateWaitingRoomServer) error {
	waitingRoom.Users[userSub.User.Id] = userSub

	users := []*hiit.WorkoutUser{}
	for _, u := range waitingRoom.Users {
		users = append(users, u.User)
	}

	response := &hiit.WaitingRoomResponse{
		Users: users,
		Start: false,
	}

	// Notify all other subscribers
	for _, u := range waitingRoom.Users {
		if u.User.Id == userSub.User.Id {
			continue
		}

		u.Listen <- response
	}
	return stream.Send(response)
}

func (svc *Service) JoinWaitingRoom(req *hiit.WaitingRoomRequest, stream hiit.HIITService_JoinWaitingRoomServer) error {
	ctx, cancel := context.WithCancel(stream.Context())
	defer cancel()

	user := req.GetUser()
	workout := req.GetWorkout()

	waitingRoom := svc.waitingRooms[workout]
	if waitingRoom == nil {
		return errors.New("Waiting Room does not exist")
	}

	listen := make(chan *hiit.WaitingRoomResponse)

	// Notify waiting room subscription
	waitingRoom.JoinSub <- &model.WaitingSub{
		User:   user,
		Listen: listen,
	}

	errCh := internal.NewErrorChannel()
	defer func() {
		errCh.Close()
		close(listen)
	}()

	go func() {
		var data *hiit.WaitingRoomResponse
		stream.Send(&hiit.WaitingRoomResponse{
			Host:  waitingRoom.Host,
			Users: waitingRoom.GetUsers(),
			Start: false,
		})

		for {
			select {
			case <-ctx.Done():
				return
			case m, ok := <-listen:
				if !ok {
					return
				}
				data = m
			}
			if err := stream.Send(data); err != nil {
				errCh.C <- err
				return
			}
		}
	}()

	select {
	case err := <-errCh.C:
		if err != nil && err != io.EOF {
			svc.logger.Errorf("%v %v", err)
		}
	case <-ctx.Done():
		fmt.Println("exit waiting room")
	}

	return nil
}

/**
Defines Pub for single hiit
*/
func (svc *Service) Pub(ctx context.Context, msg *hiit.DataSession) (*hiit.Empty, error) {
	id := msg.Session.Id
	pub := svc.pubsub[fmt.Sprintf("%s", id)]
	if pub == nil {
		return nil, errors.New("Id does not exist")
	}

	pub <- msg.Data

	return &hiit.Empty{}, nil
}

func (svc *Service) Sub(_ *hiit.RoutineChange, stream hiit.HIITService_SubServer) error {
	ctx, cancel := context.WithCancel(stream.Context())
	defer cancel()

	id := internal.GetMetadataValue(ctx, "id")

	if id == "" {
		return errors.New("Invalid ID")
	}
	fmt.Println("users", len(svc.pubsub))
	fmt.Println(id)

	listen := make(chan *hiit.Data)
	svc.pubsub[fmt.Sprintf("%s", id)] = listen

	errCh := internal.NewErrorChannel()
	defer func() {
		errCh.Close()
		close(listen)
		delete(svc.pubsub, fmt.Sprintf("%s", id))
	}()

	go func() {
		var data *hiit.Data
		for {
			select {
			case <-ctx.Done():
				return
			case m, ok := <-listen:
				if !ok {
					return
				}
				data = m
			}
			if err := stream.Send(data); err != nil {
				errCh.C <- err
				return
			}
		}
	}()

	select {
	case err := <-errCh.C:
		if err != nil && err != io.EOF {
			svc.logger.Errorf("%v %v", err)
		}
	case <-ctx.Done():
		fmt.Println("done")
	}
	return nil
}
