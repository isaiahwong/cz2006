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

func (svc *Service) CreateDuoHIIT(req *hiit.CreateDuoHIITRequest, stream hiit.HIITService_CreateDuoHIITServer) error {
	ctx, cancel := context.WithCancel(stream.Context())
	defer cancel()

	hiitWorkout := req.GetHiit()
	host := req.GetHost()

	// retrieve waiting room
	waitingRoom := svc.waitingRooms[hiitWorkout]
	if waitingRoom == nil {
		return errors.New("Cannot create HIIT, waiting room not found")
	}
	if waitingRoom.Host.Id != host.GetId() {
		return errors.New("cannot create HIIT, not host")
	}

	// Convert to userHIIT
	users := make(map[string]*model.HIITUserSession)
	for _, u := range waitingRoom.GetUsers() {
		users[u.GetId()] = &model.HIITUserSession{
			User:   u,
			Listen: make(chan *hiit.HIITActivity),
		}
	}

	hiitSession := &model.HIITSession{
		Host: &model.HIITUserSession{
			User: host,
		},
		Users:           users,
		HIITActivitySub: make(chan *hiit.HIITActivity),
		AssignedScore:   make(map[string]string),
		// UserJoinSub:     make(chan *model.HIITUserSession),
		Joined: 1, // includes host
	}

	svc.hiitSessions[hiitWorkout] = hiitSession

	errCh := internal.NewErrorChannel()
	defer func() {
		errCh.Close()
		close(hiitSession.HIITActivitySub)
		delete(svc.hiitSessions, hiitWorkout)
	}()

	fmt.Println(host.GetName(), "starting hiit")

	go func() {
		// Tell waiting room to start
		waitingRoom.Start <- host.Id

		var err error
		for {
			select {
			case <-ctx.Done():
				return
			case activity, ok := <-hiitSession.HIITActivitySub:
				if !ok {
					return
				}
				fmt.Println("received activity")
				// notify host
				if err := stream.Send(activity); err != nil {
					errCh.C <- err
					return
				}

				// Notify everyone of winner
				for _, u := range hiitSession.Users {
					u.Listen <- activity
				}

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
		fmt.Println("hiit ended")
	}
	return nil
}

func (svc *Service) DuoHIITSelectRoutine(ctx context.Context, req *hiit.HIITRequest) (*hiit.Empty, error) {
	routine := req.GetRoutine()
	user := req.GetUser()
	hiitWorkout := req.GetHiit()

	if user == nil {
		return nil, errors.New("user is nil")
	}

	// get hiit
	hiitSession := svc.hiitSessions[hiitWorkout]
	if hiitSession == nil {
		return nil, errors.New("hiit session does not exist")
	}

	var hiitUser *model.HIITUserSession
	if user.Id == hiitSession.Host.User.Id {
		hiitUser = hiitSession.Host
	} else {
		// check if user in sesssion
		hiitUser = hiitSession.Users[user.GetId()]
	}
	if hiitUser == nil {
		return nil, errors.New("hiit user is not in session")
	}

	// TODO winner or host select
	hiitSession.HIITActivitySub <- &hiit.HIITActivity{
		Hiit:    hiitWorkout,
		User:    hiitUser.User,
		Routine: routine,
		Type:    hiit.HIITActivity_ROUTINE_CHANGE,
	}

	return &hiit.Empty{}, nil
}

func (svc *Service) HIITRoutineComplete(ctx context.Context, req *hiit.HIITRequest) (*hiit.Empty, error) {
	routine := req.GetRoutine()
	user := req.GetUser()
	hiitWorkout := req.GetHiit()

	// get hiit
	hiitSession := svc.hiitSessions[hiitWorkout]
	if hiitSession == nil {
		return nil, errors.New("hiit session does not exist")
	}

	if user.Id != hiitSession.Host.User.Id {
		return nil, errors.New("hiit session can only be completed by host")
	}

	highestUser := hiitSession.Host
	// get highest score
	for _, u := range hiitSession.Users {
		if u.User.Score > highestUser.User.Score {
			highestUser = u
		} else {
			// reset score
			u.User.Score = 0
		}
	}

	hiitSession.HIITActivitySub <- &hiit.HIITActivity{
		Hiit:    hiitWorkout,
		User:    user,
		Routine: routine,
		Winner:  highestUser.User,
		Type:    hiit.HIITActivity_INTERVAL_COMPLETE,
	}

	// reset highestUser
	highestUser.User.Score = 0
	return &hiit.Empty{}, nil

}

func (svc *Service) HIITIntervalComplete(ctx context.Context, req *hiit.HIITRequest) (*hiit.Empty, error) {
	routine := req.GetRoutine()
	user := req.GetUser()
	hiitWorkout := req.GetHiit()

	if user == nil {
		return nil, errors.New("user is nil")
	}

	// get hiit
	hiitSession := svc.hiitSessions[hiitWorkout]
	if hiitSession == nil {
		return nil, errors.New("hiit session does not exist")
	}

	var hiitUser *model.HIITUserSession
	if user.Id == hiitSession.Host.User.Id {
		hiitUser = hiitSession.Host
	} else {
		// check if user in sesssion
		hiitUser = hiitSession.Users[user.GetId()]
	}
	if hiitUser == nil {
		return nil, errors.New("hiit user is not in session")
	}

	// Verify score has not been assigned
	if id := hiitSession.AssignedScore[routine.Interval.GetId()]; id == "" {
		hiitSession.AssignedScore[routine.Interval.GetId()] = user.GetId()
		// Increment Score
		hiitUser.User.Score++
	}

	hiitSession.HIITActivitySub <- &hiit.HIITActivity{
		Hiit:    hiitWorkout,
		User:    hiitUser.User,
		Routine: routine,
		Type:    hiit.HIITActivity_INTERVAL_COMPLETE,
	}
	return &hiit.Empty{}, nil
}

func (svc *Service) JoinDuoHIIT(req *hiit.JoinDuoHIITRequest, stream hiit.HIITService_JoinDuoHIITServer) error {
	ctx, cancel := context.WithCancel(stream.Context())
	defer cancel()

	hiitWorkout := req.GetHiit()
	user := req.GetUser()

	// Get hiit session
	hiitSession := svc.hiitSessions[hiitWorkout]
	if hiitSession == nil {
		return errors.New("hiit session not found")
	}

	// Get user from hiit session
	hiitUser := hiitSession.Users[user.GetId()]
	if hiitUser == nil {
		return errors.New("user not found")
	}

	errCh := internal.NewErrorChannel()
	defer func() {
		errCh.Close()
		close(hiitUser.Listen)
	}()

	go func() {
		for {
			select {
			case <-ctx.Done():
				return
			case activity, ok := <-hiitUser.Listen:
				if !ok {
					return
				}
				fmt.Println("notify")
				if err := stream.Send(activity); err != nil {
					errCh.C <- err
					return
				}
			}

		}
	}()

	select {
	case err := <-errCh.C:
		if err != nil && err != io.EOF {
			svc.logger.Errorf("%v %v", err)
		}
	case <-ctx.Done():
		fmt.Println("hiit ended")
	}
	return nil
}
