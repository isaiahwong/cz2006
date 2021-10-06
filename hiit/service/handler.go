package service

import (
	"context"
	"errors"
	"fmt"
	"io"

	hiit "github.com/isaiahwong/hiit/api"
	"github.com/isaiahwong/hiit/internal"
)

func (svc *Service) Pub(ctx context.Context, msg *hiit.DataSession) (*hiit.Empty, error) {
	id := msg.Session.Id
	pub := svc.pubsub[fmt.Sprintf("%s", id)]
	if pub == nil {
		return nil, errors.New("Id does not exist")
	}

	pub <- msg.Data

	return &hiit.Empty{}, nil
}

func (svc *Service) Sub(stream hiit.HIITService_SubServer) error {
	ctx, cancel := context.WithCancel(stream.Context())
	defer cancel()

	id := internal.GetMetadataValue(ctx, "id")

	if id == "" {
		return errors.New("Invalid ID")
	}

	fmt.Println(id)

	listen := make(chan *hiit.Data)
	svc.pubsub[fmt.Sprintf("%s", id)] = listen

	errCh := internal.NewErrorChannel()
	close := func() {
		errCh.Close()
		close(listen)
		delete(svc.pubsub, fmt.Sprintf("%s", id))
	}

	// Monitor client's alive status
	go func() {
		defer close()
		for {
			_, err := stream.Recv()
			if err != nil {
				if !errCh.IsClosed() {
					select {
					case errCh.C <- err:
					default:
					}
				}
				return
			}
		}
	}()

	go func() {
		var data *hiit.Data
		for {
			select {
			case <-ctx.Done():
				return
			case m, ok := <-listen:
				if !ok {
					return
				}
				data = m
			}
			if err := stream.Send(data); err != nil {
				errCh.C <- err
				return
			}
		}
	}()

	select {
	case err := <-errCh.C:
		fmt.Println(err)
		if err != nil && err != io.EOF {
			svc.logger.Errorf("%v %v", err)
		}
	case <-ctx.Done():
		fmt.Println("done")
	}
	fmt.Println("here")
	return nil
}
