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
			Score:  0,
			Listen: make(chan *hiit.DuoHIITResult),
		}
	}
	// add host as well
	users[host.GetId()] = &model.HIITUserSession{
		User:   host,
		Score:  0,
		Listen: make(chan *hiit.DuoHIITResult),
	}

	// Delete waiting room
	delete(svc.waitingRooms, hiitWorkout)

	hiitSession := &model.HIITSession{
		Host: &model.HIITUserSession{
			User:  host,
			Score: 0,
		},
		Users:           users,
		HIITActivitySub: make(chan *hiit.HIITActivity),
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
		var err error
		for {
			select {
			case <-ctx.Done():
				return
			case activity, ok := <-hiitSession.HIITActivitySub:
				if !ok {
					return
				}

				// Process winner
				winner := hiitSession.Users[activity.User.GetId()]
				winner.Score++

				// Notify everyone of winner
				for _, u := range hiitSession.Users {
					u.Listen <- &hiit.DuoHIITResult{
						Winner:   winner.User,
						Score:    int32(winner.Score),
						Activity: activity,
					}
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
