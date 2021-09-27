package service

import (
	"time"

	"github.com/sirupsen/logrus"
	"google.golang.org/grpc"
)

// ServiceOption sets options
type ServiceOption func(*Service)

// WithLogger returns a ServiceOption that will set the internal
// logging of the server
func WithLogger(l *logrus.Logger) ServiceOption {
	return func(o *Service) {
		o.logger = l
	}
}

// WithGrpc returns a ServiceOption that will set the gRPC server
func WithGrpc(g *grpc.Server) ServiceOption {
	return func(o *Service) {
		o.grpcServer = g
	}
}

//// WithRedis returns a ServiceOption that sets the redis store the service will use
//func WithRedis(r *redis.Client) ServiceOption {
//	return func(o *Service) {
//		o.redisClient = r
//	}
//}

// WithServiceTimeout returns a ServiceOption that sets the time out of
// external services call
func WithServiceTimeout(t time.Duration) ServiceOption {
	return func(o *Service) {
		o.serviceTimeout = t
	}
}

// SetEnvironment returns a ServiceOption that sets the service environment
func SetEnvironment(production bool) ServiceOption {
	return func(o *Service) {
		o.production = production
	}
}
