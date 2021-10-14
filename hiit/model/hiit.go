package model

import hiit "github.com/isaiahwong/hiit/api"

type HIITSession struct {
	Host            *HIITUserSession
	Users           map[string]*HIITUserSession
	HIITActivitySub chan (*hiit.HIITActivity)
	// UserJoinSub     chan (*hiit.WorkoutUser)
	Joined int
}

type HIITUserSession struct {
	User   *hiit.WorkoutUser
	Score  int
	Listen chan *hiit.DuoHIITResult
}
