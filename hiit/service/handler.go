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

func (svc *Service) SubInvites(user *hiit.HIITUser, stream hiit.HIITService_SubInvitesServer) error {
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
		var data *hiit.InviteWaitingRoomRequest
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
		fmt.Println(user.GetId(), user.GetName(), " has left")
	}
	return nil
}

func (svc *Service) CreateWaitingRoom(req *hiit.CreateWaitingRoomRequest, stream hiit.HIITService_CreateWaitingRoomServer) error {
	ctx, cancel := context.WithCancel(stream.Context())
	defer cancel()

	hiitWorkout := req.GetHiit()
	host := req.GetHost()

	waitingRoom := &model.WaitingRoom{
		Host:    host,
		HIIT:    hiitWorkout,
		JoinSub: make(chan *model.WaitingSub),
		Start:   make(chan string),
	}

	fmt.Println(host.GetName(), "created room")

	svc.waitingRooms[hiitWorkout] = waitingRoom

	errCh := internal.NewErrorChannel()
	defer func() {
		errCh.Close()
		close(waitingRoom.JoinSub)
		delete(svc.waitingRooms, hiitWorkout)
	}()

	go func() {
		var err error
		for {
			select {
			case <-ctx.Done():
				return
			case userSub, ok := <-waitingRoom.JoinSub:
				if !ok {
					return
				}
				err = svc.notifyWaiting(userSub, waitingRoom, stream)
			case start, ok := <-waitingRoom.Start:
				if !ok {
					return
				}
				if start != waitingRoom.Host.Id {
					return
				}
				// start logic
			}

			if err != nil {
				errCh.C <- err
				return
			}

		}
	}()

	return nil
}

func (svc *Service) notifyWaiting(userSub *model.WaitingSub, waitingRoom *model.WaitingRoom, stream hiit.HIITService_CreateWaitingRoomServer) error {
	waitingRoom.Users[userSub.User.Id] = userSub

	users := []*hiit.HIITUser{}
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
	hiitWorkout := req.GetHiit()

	waitingRoom := svc.waitingRooms[hiitWorkout]
	if waitingRoom == nil {
		return errors.New("Waiting Room does not exist")
	}

	listen := make(chan *hiit.WaitingRoomResponse)

	waitingRoom.JoinSub <- &model.WaitingSub{
		User:   user,
		Listen: listen,
	}

	errCh := internal.NewErrorChannel()
	defer func() {
		errCh.Close()
		close(listen)
		delete(waitingRoom.Users, user.Id)
	}()

	go func() {
		var data *hiit.WaitingRoomResponse
		// send initial
		users := []*hiit.HIITUser{}

		for _, u := range waitingRoom.Users {
			users = append(users, u.User)
		}
		stream.Send(&hiit.WaitingRoomResponse{
			Users: users,
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

	return nil
}

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
