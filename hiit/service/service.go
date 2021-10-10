package service

import (
	"context"
	"errors"
	"time"

	"github.com/go-playground/validator"
	hiit "github.com/isaiahwong/hiit/api"
	"github.com/isaiahwong/hiit/internal"
	"github.com/isaiahwong/hiit/model"
	"github.com/microcosm-cc/bluemonday"
	"github.com/sirupsen/logrus"
	"google.golang.org/grpc"
)

type Service struct {
	production     bool
	logger         *logrus.Logger
	grpcServer     *grpc.Server
	policy         *bluemonday.Policy
	validate       *validator.Validate
	serviceTimeout time.Duration
	pubsub         map[string]chan *hiit.Data
	waitingRooms   map[string]*model.WaitingRoom
	users          map[string]chan *hiit.InviteWaitingRoomRequest

	hiit.UnimplementedHIITServiceServer
}

func New(ctx context.Context, opt ...ServiceOption) error {
	// Default Service options
	s := &Service{
		logger:       internal.NewLogrusLogger(),
		policy:       bluemonday.StrictPolicy(),
		validate:     validator.New(),
		pubsub:       make(map[string]chan *hiit.Data),
		waitingRooms: make(map[string]*model.WaitingRoom),
		users:        make(map[string]chan *hiit.InviteWaitingRoomRequest),
	}
	// Apply options
	for _, o := range opt {
		o(s)
	}
	if s.grpcServer == nil {
		return errors.New("grpcServer is nil. Service requires type *grpc.Server")
	}

	hiit.RegisterHIITServiceServer(s.grpcServer, s)

	return nil
}
