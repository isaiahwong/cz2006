package main

import (
	"context"

	"github.com/isaiahwong/hiit/internal"
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

	select {
	case <-ctx.Done():
		s.Gracefully(ctx)
	}
}
