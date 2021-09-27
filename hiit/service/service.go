package service

import (
	"context"
	"errors"
	"time"

	"github.com/go-playground/validator"
	hiit "github.com/isaiahwong/hiit/api"
	"github.com/isaiahwong/hiit/internal"
	"github.com/microcosm-cc/bluemonday"
	"github.com/sirupsen/logrus"
	"google.golang.org/grpc"
)

type Service struct {
	production     bool
	test           bool
	logger         *logrus.Logger
	grpcServer     *grpc.Server
	policy         *bluemonday.Policy
	validate       *validator.Validate
	serviceTimeout time.Duration

	hiit.UnimplementedHIITServiceServer
}

func NewService(ctx context.Context, opt ...ServiceOption) error {
	// Default Service options
	s := &Service{
		logger:   internal.NewLogrusLogger(),
		policy:   bluemonday.StrictPolicy(),
		validate: validator.New(),
	}
	// Apply options
	for _, o := range opt {
		o(s)
	}
	if s.grpcServer == nil {
		return errors.New("grpcServer is nil. RegisterService requires type *grpc.Server")
	}

	hiit.RegisterHIITServiceServer(s.grpcServer, s)

	return nil
}
