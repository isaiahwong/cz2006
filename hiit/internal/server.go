package internal

import (
	"context"
	"net"
	"net/http"
	"reflect"
	"strings"

	grpc_middleware "github.com/grpc-ecosystem/go-grpc-middleware"
	grpc_logrus "github.com/grpc-ecosystem/go-grpc-middleware/logging/logrus"
	hiit "github.com/isaiahwong/hiit/api"
	"github.com/sirupsen/logrus"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

// Server encapsulates authentication and account operations
type Server struct {
	GRPCServer     *grpc.Server
	Name           string
	Production     bool
	insecureServer net.Listener
	logger         *logrus.Logger
	hiit.UnimplementedHIITServiceServer
}

// Serve starts gRPC server as well as other dependencies such as connect to store
func (s *Server) Serve(ctx context.Context) error {
	ctx, cancel := context.WithCancel(ctx)
	defer cancel()

	// Serve Insecurely
	go func() {
		s.logger.Infof("Serving insecure %v on %v %v", s.Name, s.insecureServer.Addr().Network(), s.insecureServer.Addr().String())
		s.logger.Infof("Production: %v", s.Production)
		if err := s.GRPCServer.Serve(s.insecureServer); err != nil && err != http.ErrServerClosed {
			s.logger.Errorf("Serve: %v", err)
		}
		cancel()
	}()

	return nil
}

func (s *Server) Gracefully(ctx context.Context) {
	ctx, cancel := context.WithCancel(ctx)
	defer cancel()
	s.GRPCServer.Stop()
	s.insecureServer.Close()
	s.logger.Infof("%v closed\n", s.Name)
}

func LoggerDecider(method string, err error) bool {
	exclude := []string{
		"/grpc.health.v1.Health/Check",
	}
	if err != nil {
		return true
	}
	for _, e := range exclude {
		if strings.Contains(method, e) {
			return false
		}
	}
	return true
}

// New returns a new Server
func New(opt ...Option) (*Server, error) {
	// Apply passed in options
	opts := defaultServerOptions
	for _, o := range opt {
		o(&opts)
	}
	logger := &logrus.Logger{}

	// We set the value of opts.logger to interface type logrus.Logger
	// In this case, we only support logrus.Logger thus no error checks
	// are performed.
	// TODO: Refactor to check type of logger before setting to the
	// respective interface
	func(i, o interface{}) {
		reflect.ValueOf(o).Elem().Set(reflect.ValueOf(i))
	}(opts.logger, &logger)

	// Create a new gRPC server
	insecureGrpc := grpc.NewServer(
		grpc.MaxRecvMsgSize(1024*1024*20),
		grpc.UnaryInterceptor(grpc_middleware.ChainUnaryServer(
			grpc_logrus.UnaryServerInterceptor(
				logrus.NewEntry(logger),
				grpc_logrus.WithDecider(LoggerDecider),
			),
		)),
	)

	// Create a new network listener
	insecureServer, err := net.Listen("tcp", opts.address)
	if err != nil {
		return nil, err
	}

	server := &Server{
		GRPCServer:     insecureGrpc,
		insecureServer: insecureServer,
		logger:         opts.logger,
		Production:     opts.production,
		Name:           opts.name,
	}

	// Register HealthService
	hiit.RegisterHIITServiceServer(insecureGrpc, server)
	reflection.Register(server.GRPCServer)
	return server, nil
}
