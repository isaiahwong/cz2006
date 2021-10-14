package model

import hiit "github.com/isaiahwong/hiit/api"

type HIITSession struct {
	Users *[]HIITUserSession
}

type HIITUserSession struct {
	User  *hiit.WorkoutUser
	Score int
}
