package model

import hiit "github.com/isaiahwong/hiit/api"

type WaitingRoom struct {
	Host    *hiit.HIITUser
	HIIT    string
	Users   map[string]*WaitingSub
	JoinSub chan (*WaitingSub)
	Start   chan (string)
}

type WaitingSub struct {
	User   *hiit.HIITUser
	Listen chan *hiit.WaitingRoomResponse
}
