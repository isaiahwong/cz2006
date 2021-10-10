///
//  Generated code. Do not modify.
//  source: hiit.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'hiit.pb.dart' as $0;
export 'hiit.pb.dart';

class HIITServiceClient extends $grpc.Client {
  static final _$sub = $grpc.ClientMethod<$0.RoutineChange, $0.Data>(
      '/hiit.HIITService/Sub',
      ($0.RoutineChange value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Data.fromBuffer(value));
  static final _$pub = $grpc.ClientMethod<$0.DataSession, $0.Empty>(
      '/hiit.HIITService/Pub',
      ($0.DataSession value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$createWaitingRoom =
      $grpc.ClientMethod<$0.CreateWaitingRoomRequest, $0.WaitingRoomResponse>(
          '/hiit.HIITService/CreateWaitingRoom',
          ($0.CreateWaitingRoomRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.WaitingRoomResponse.fromBuffer(value));
  static final _$joinWaitingRoom =
      $grpc.ClientMethod<$0.WaitingRoomRequest, $0.WaitingRoomResponse>(
          '/hiit.HIITService/JoinWaitingRoom',
          ($0.WaitingRoomRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.WaitingRoomResponse.fromBuffer(value));
  static final _$notifyInvites =
      $grpc.ClientMethod<$0.InviteWaitingRoomRequest, $0.Empty>(
          '/hiit.HIITService/NotifyInvites',
          ($0.InviteWaitingRoomRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$subInvites =
      $grpc.ClientMethod<$0.HIITUser, $0.InviteWaitingRoomRequest>(
          '/hiit.HIITService/SubInvites',
          ($0.HIITUser value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.InviteWaitingRoomRequest.fromBuffer(value));

  HIITServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$0.Data> sub($0.RoutineChange request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$sub, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.Empty> pub($0.DataSession request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$pub, request, options: options);
  }

  $grpc.ResponseStream<$0.WaitingRoomResponse> createWaitingRoom(
      $0.CreateWaitingRoomRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$createWaitingRoom, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$0.WaitingRoomResponse> joinWaitingRoom(
      $0.WaitingRoomRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$joinWaitingRoom, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.Empty> notifyInvites(
      $0.InviteWaitingRoomRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$notifyInvites, request, options: options);
  }

  $grpc.ResponseStream<$0.InviteWaitingRoomRequest> subInvites(
      $0.HIITUser request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$subInvites, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class HIITServiceBase extends $grpc.Service {
  $core.String get $name => 'hiit.HIITService';

  HIITServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.RoutineChange, $0.Data>(
        'Sub',
        sub_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.RoutineChange.fromBuffer(value),
        ($0.Data value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DataSession, $0.Empty>(
        'Pub',
        pub_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DataSession.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateWaitingRoomRequest,
            $0.WaitingRoomResponse>(
        'CreateWaitingRoom',
        createWaitingRoom_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $0.CreateWaitingRoomRequest.fromBuffer(value),
        ($0.WaitingRoomResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.WaitingRoomRequest, $0.WaitingRoomResponse>(
            'JoinWaitingRoom',
            joinWaitingRoom_Pre,
            false,
            true,
            ($core.List<$core.int> value) =>
                $0.WaitingRoomRequest.fromBuffer(value),
            ($0.WaitingRoomResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.InviteWaitingRoomRequest, $0.Empty>(
        'NotifyInvites',
        notifyInvites_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.InviteWaitingRoomRequest.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.HIITUser, $0.InviteWaitingRoomRequest>(
        'SubInvites',
        subInvites_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.HIITUser.fromBuffer(value),
        ($0.InviteWaitingRoomRequest value) => value.writeToBuffer()));
  }

  $async.Stream<$0.Data> sub_Pre(
      $grpc.ServiceCall call, $async.Future<$0.RoutineChange> request) async* {
    yield* sub(call, await request);
  }

  $async.Future<$0.Empty> pub_Pre(
      $grpc.ServiceCall call, $async.Future<$0.DataSession> request) async {
    return pub(call, await request);
  }

  $async.Stream<$0.WaitingRoomResponse> createWaitingRoom_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateWaitingRoomRequest> request) async* {
    yield* createWaitingRoom(call, await request);
  }

  $async.Stream<$0.WaitingRoomResponse> joinWaitingRoom_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.WaitingRoomRequest> request) async* {
    yield* joinWaitingRoom(call, await request);
  }

  $async.Future<$0.Empty> notifyInvites_Pre($grpc.ServiceCall call,
      $async.Future<$0.InviteWaitingRoomRequest> request) async {
    return notifyInvites(call, await request);
  }

  $async.Stream<$0.InviteWaitingRoomRequest> subInvites_Pre(
      $grpc.ServiceCall call, $async.Future<$0.HIITUser> request) async* {
    yield* subInvites(call, await request);
  }

  $async.Stream<$0.Data> sub($grpc.ServiceCall call, $0.RoutineChange request);
  $async.Future<$0.Empty> pub($grpc.ServiceCall call, $0.DataSession request);
  $async.Stream<$0.WaitingRoomResponse> createWaitingRoom(
      $grpc.ServiceCall call, $0.CreateWaitingRoomRequest request);
  $async.Stream<$0.WaitingRoomResponse> joinWaitingRoom(
      $grpc.ServiceCall call, $0.WaitingRoomRequest request);
  $async.Future<$0.Empty> notifyInvites(
      $grpc.ServiceCall call, $0.InviteWaitingRoomRequest request);
  $async.Stream<$0.InviteWaitingRoomRequest> subInvites(
      $grpc.ServiceCall call, $0.HIITUser request);
}
