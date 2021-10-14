package service

import (
	"context"

	hiit "github.com/isaiahwong/hiit/api"
)

func (svc *Service) StartDuoHIIT(req *hiit.DuoHIITRequest, stream hiit.HIITService_StartDuoHIITServer) error {
	ctx, cancel := context.WithCancel(stream.Context())
	defer cancel()

}
