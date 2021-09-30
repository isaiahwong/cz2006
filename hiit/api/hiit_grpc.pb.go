// Code generated by protoc-gen-go-grpc. DO NOT EDIT.

package hiit

import (
	context "context"
	grpc "google.golang.org/grpc"
	codes "google.golang.org/grpc/codes"
	status "google.golang.org/grpc/status"
)

// This is a compile-time assertion to ensure that this generated file
// is compatible with the grpc package it is being compiled against.
const _ = grpc.SupportPackageIsVersion7

// HIITServiceClient is the client API for HIITService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
type HIITServiceClient interface {
	Sub(ctx context.Context, opts ...grpc.CallOption) (HIITService_SubClient, error)
	Pub(ctx context.Context, in *DataSession, opts ...grpc.CallOption) (*Empty, error)
}

type hIITServiceClient struct {
	cc grpc.ClientConnInterface
}

func NewHIITServiceClient(cc grpc.ClientConnInterface) HIITServiceClient {
	return &hIITServiceClient{cc}
}

func (c *hIITServiceClient) Sub(ctx context.Context, opts ...grpc.CallOption) (HIITService_SubClient, error) {
	stream, err := c.cc.NewStream(ctx, &_HIITService_serviceDesc.Streams[0], "/hiit.HIITService/Sub", opts...)
	if err != nil {
		return nil, err
	}
	x := &hIITServiceSubClient{stream}
	return x, nil
}

type HIITService_SubClient interface {
	Send(*Ping) error
	Recv() (*Data, error)
	grpc.ClientStream
}

type hIITServiceSubClient struct {
	grpc.ClientStream
}

func (x *hIITServiceSubClient) Send(m *Ping) error {
	return x.ClientStream.SendMsg(m)
}

func (x *hIITServiceSubClient) Recv() (*Data, error) {
	m := new(Data)
	if err := x.ClientStream.RecvMsg(m); err != nil {
		return nil, err
	}
	return m, nil
}

func (c *hIITServiceClient) Pub(ctx context.Context, in *DataSession, opts ...grpc.CallOption) (*Empty, error) {
	out := new(Empty)
	err := c.cc.Invoke(ctx, "/hiit.HIITService/Pub", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

// HIITServiceServer is the server API for HIITService service.
// All implementations must embed UnimplementedHIITServiceServer
// for forward compatibility
type HIITServiceServer interface {
	Sub(HIITService_SubServer) error
	Pub(context.Context, *DataSession) (*Empty, error)
	mustEmbedUnimplementedHIITServiceServer()
}

// UnimplementedHIITServiceServer must be embedded to have forward compatible implementations.
type UnimplementedHIITServiceServer struct {
}

func (UnimplementedHIITServiceServer) Sub(HIITService_SubServer) error {
	return status.Errorf(codes.Unimplemented, "method Sub not implemented")
}
func (UnimplementedHIITServiceServer) Pub(context.Context, *DataSession) (*Empty, error) {
	return nil, status.Errorf(codes.Unimplemented, "method Pub not implemented")
}
func (UnimplementedHIITServiceServer) mustEmbedUnimplementedHIITServiceServer() {}

// UnsafeHIITServiceServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to HIITServiceServer will
// result in compilation errors.
type UnsafeHIITServiceServer interface {
	mustEmbedUnimplementedHIITServiceServer()
}

func RegisterHIITServiceServer(s *grpc.Server, srv HIITServiceServer) {
	s.RegisterService(&_HIITService_serviceDesc, srv)
}

func _HIITService_Sub_Handler(srv interface{}, stream grpc.ServerStream) error {
	return srv.(HIITServiceServer).Sub(&hIITServiceSubServer{stream})
}

type HIITService_SubServer interface {
	Send(*Data) error
	Recv() (*Ping, error)
	grpc.ServerStream
}

type hIITServiceSubServer struct {
	grpc.ServerStream
}

func (x *hIITServiceSubServer) Send(m *Data) error {
	return x.ServerStream.SendMsg(m)
}

func (x *hIITServiceSubServer) Recv() (*Ping, error) {
	m := new(Ping)
	if err := x.ServerStream.RecvMsg(m); err != nil {
		return nil, err
	}
	return m, nil
}

func _HIITService_Pub_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(DataSession)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(HIITServiceServer).Pub(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/hiit.HIITService/Pub",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(HIITServiceServer).Pub(ctx, req.(*DataSession))
	}
	return interceptor(ctx, in, info, handler)
}

var _HIITService_serviceDesc = grpc.ServiceDesc{
	ServiceName: "hiit.HIITService",
	HandlerType: (*HIITServiceServer)(nil),
	Methods: []grpc.MethodDesc{
		{
			MethodName: "Pub",
			Handler:    _HIITService_Pub_Handler,
		},
	},
	Streams: []grpc.StreamDesc{
		{
			StreamName:    "Sub",
			Handler:       _HIITService_Sub_Handler,
			ServerStreams: true,
			ClientStreams: true,
		},
	},
	Metadata: "hiit.proto",
}