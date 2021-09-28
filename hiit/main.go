package main

import (
	"context"

	"github.com/isaiahwong/hiit/internal"
	"github.com/isaiahwong/hiit/service"
)

func main() {
	config := internal.LoadEnv()

	l := internal.NewLogrusLogger()
	ctx := internal.SignalContext(context.Background())

	// Initialize a new Server
	s, err := internal.New(
		internal.WithAddress(config.Address),
		internal.WithLogger(l),
		internal.WithName("HIIT Service"),
		internal.WithAppEnvironment(config.Production),
	)
	if err != nil {
		l.Fatalf("NewServer: %v", err)
	}

	// Register service
	err = service.New(
		ctx,
		service.WithLogger(l),
		service.WithGrpc(s.GRPCServer),
		service.WithServiceTimeout(config.ServiceTimeout),
	)
	if err != nil {
		l.Fatalf("NewService: %v", err)
	}

	// Start Server
	if err := s.Serve(ctx); err != nil {
		l.Fatalf("Serve: %v", err)
	}
	<-ctx.Done()
	s.Gracefully(ctx)
}
