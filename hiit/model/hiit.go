package model

import hiit "github.com/isaiahwong/hiit/api"

type HIITSession struct {
	Host            *HIITUserSession
	Users           map[string]*HIITUserSession
	HIITActivitySub chan (*hiit.HIITActivity)
	// UserJoinSub     chan (*hiit.WorkoutUser)
	// Ensures that scores are not assigned Twice
	AssignedScore map[string]string
	Joined        int
	Winner        *HIITUserSession
}

type HIITUserSession struct {
	User   *hiit.WorkoutUser
	Listen chan *hiit.HIITActivity
}
