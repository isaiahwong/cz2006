package model

import hiit "github.com/isaiahwong/hiit/api"

type WaitingRoom struct {
	Host    *hiit.WorkoutUser
	HIIT    string
	Users   map[string]*WaitingSub
	JoinSub chan (*WaitingSub)
	Start   chan (string)
}

type WaitingSub struct {
	User   *hiit.WorkoutUser
	Listen chan *hiit.WaitingRoomResponse
}
