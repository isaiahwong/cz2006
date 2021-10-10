package model

import hiit "github.com/isaiahwong/hiit/api"

type WaitingRoom struct {
	Host    *hiit.HIITUser
	HIIT    string
	Users   []*WaitingSub
	JoinSub chan (*WaitingSub)
}

type WaitingSub struct {
	User   *hiit.HIITUser
	Listen chan *hiit.WaitingRoomResponse
}
