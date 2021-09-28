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
	topic := msg.Session.Topic

	pub := svc.pubsub[fmt.Sprintf("%s:%s", id, topic)]
	if pub == nil {
		return nil, errors.New("Id topic does not exist")
	}

	pub <- msg.Data

	return nil, nil
}

func (svc *Service) Sub(stream hiit.HIITService_SubServer) error {
	ctx, cancel := context.WithCancel(stream.Context())
	defer cancel()

	id := internal.GetMetadataValue(ctx, "id")
	topic := internal.GetMetadataValue(ctx, "topic")

	if id == "" {
		return errors.New("Invalid ID")
	}

	if topic == "" {
		return errors.New("Invalid topic")
	}

	listen := make(chan *hiit.Data)
	svc.pubsub[fmt.Sprintf("%s:%s", id, topic)] = listen

	errCh := internal.NewErrorChannel()
	defer func() {
		errCh.Close()
		close(listen)
		delete(svc.pubsub, fmt.Sprintf("%s:%s", id, topic))
	}()

	// Monitor client's alive status
	go func() {
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
		if err != nil && err != io.EOF {
			svc.logger.Errorf("%v %v", err)
		}
	case <-ctx.Done():
	}

	return nil
}
