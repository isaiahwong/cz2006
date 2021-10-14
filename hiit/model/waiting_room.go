package model

import hiit "github.com/isaiahwong/hiit/api"

type WaitingRoom struct {
	Host    *hiit.WorkoutUser
	Workout string
	Users   map[string]*WaitingSub
	JoinSub chan (*WaitingSub)
	Start   chan (string)
	Started bool
}

func (w *WaitingRoom) GetUsers() (users []*hiit.WorkoutUser) {
	for _, v := range w.Users {
		users = append(users, v.User)
	}
	return
}

type WaitingSub struct {
	User   *hiit.WorkoutUser
	Listen chan *hiit.WaitingRoomResponse
}
