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
  static final _$startWaitingRoom =
      $grpc.ClientMethod<$0.StartWaitingRoomRequest, $0.Empty>(
          '/hiit.HIITService/StartWaitingRoom',
          ($0.StartWaitingRoomRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$notifyInvites =
      $grpc.ClientMethod<$0.InviteWaitingRoomRequest, $0.Empty>(
          '/hiit.HIITService/NotifyInvites',
          ($0.InviteWaitingRoomRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$subInvites =
      $grpc.ClientMethod<$0.WorkoutUser, $0.InviteWaitingRoomRequest>(
          '/hiit.HIITService/SubInvites',
          ($0.WorkoutUser value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.InviteWaitingRoomRequest.fromBuffer(value));
  static final _$createDuoHIIT =
      $grpc.ClientMethod<$0.CreateDuoHIITRequest, $0.HIITActivity>(
          '/hiit.HIITService/CreateDuoHIIT',
          ($0.CreateDuoHIITRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.HIITActivity.fromBuffer(value));
  static final _$joinDuoHIIT =
      $grpc.ClientMethod<$0.JoinDuoHIITRequest, $0.HIITActivity>(
          '/hiit.HIITService/JoinDuoHIIT',
          ($0.JoinDuoHIITRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.HIITActivity.fromBuffer(value));
  static final _$hIITIntervalComplete =
      $grpc.ClientMethod<$0.HIITRequest, $0.Empty>(
          '/hiit.HIITService/HIITIntervalComplete',
          ($0.HIITRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$hIITRoutineComplete =
      $grpc.ClientMethod<$0.HIITRequest, $0.Empty>(
          '/hiit.HIITService/HIITRoutineComplete',
          ($0.HIITRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$duoHIITSelectRoutine =
      $grpc.ClientMethod<$0.HIITRequest, $0.Empty>(
          '/hiit.HIITService/DuoHIITSelectRoutine',
          ($0.HIITRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$hIITWinnerSelectRoutine =
      $grpc.ClientMethod<$0.HIITRequest, $0.Empty>(
          '/hiit.HIITService/HIITWinnerSelectRoutine',
          ($0.HIITRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));

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

  $grpc.ResponseFuture<$0.Empty> startWaitingRoom(
      $0.StartWaitingRoomRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$startWaitingRoom, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> notifyInvites(
      $0.InviteWaitingRoomRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$notifyInvites, request, options: options);
  }

  $grpc.ResponseStream<$0.InviteWaitingRoomRequest> subInvites(
      $0.WorkoutUser request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$subInvites, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$0.HIITActivity> createDuoHIIT(
      $0.CreateDuoHIITRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$createDuoHIIT, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$0.HIITActivity> joinDuoHIIT(
      $0.JoinDuoHIITRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$joinDuoHIIT, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.Empty> hIITIntervalComplete($0.HIITRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$hIITIntervalComplete, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> hIITRoutineComplete($0.HIITRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$hIITRoutineComplete, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> duoHIITSelectRoutine($0.HIITRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$duoHIITSelectRoutine, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> hIITWinnerSelectRoutine($0.HIITRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$hIITWinnerSelectRoutine, request,
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
    $addMethod($grpc.ServiceMethod<$0.StartWaitingRoomRequest, $0.Empty>(
        'StartWaitingRoom',
        startWaitingRoom_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.StartWaitingRoomRequest.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.InviteWaitingRoomRequest, $0.Empty>(
        'NotifyInvites',
        notifyInvites_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.InviteWaitingRoomRequest.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.WorkoutUser, $0.InviteWaitingRoomRequest>(
        'SubInvites',
        subInvites_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.WorkoutUser.fromBuffer(value),
        ($0.InviteWaitingRoomRequest value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateDuoHIITRequest, $0.HIITActivity>(
        'CreateDuoHIIT',
        createDuoHIIT_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $0.CreateDuoHIITRequest.fromBuffer(value),
        ($0.HIITActivity value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.JoinDuoHIITRequest, $0.HIITActivity>(
        'JoinDuoHIIT',
        joinDuoHIIT_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $0.JoinDuoHIITRequest.fromBuffer(value),
        ($0.HIITActivity value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.HIITRequest, $0.Empty>(
        'HIITIntervalComplete',
        hIITIntervalComplete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.HIITRequest.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.HIITRequest, $0.Empty>(
        'HIITRoutineComplete',
        hIITRoutineComplete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.HIITRequest.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.HIITRequest, $0.Empty>(
        'DuoHIITSelectRoutine',
        duoHIITSelectRoutine_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.HIITRequest.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.HIITRequest, $0.Empty>(
        'HIITWinnerSelectRoutine',
        hIITWinnerSelectRoutine_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.HIITRequest.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
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

  $async.Future<$0.Empty> startWaitingRoom_Pre($grpc.ServiceCall call,
      $async.Future<$0.StartWaitingRoomRequest> request) async {
    return startWaitingRoom(call, await request);
  }

  $async.Future<$0.Empty> notifyInvites_Pre($grpc.ServiceCall call,
      $async.Future<$0.InviteWaitingRoomRequest> request) async {
    return notifyInvites(call, await request);
  }

  $async.Stream<$0.InviteWaitingRoomRequest> subInvites_Pre(
      $grpc.ServiceCall call, $async.Future<$0.WorkoutUser> request) async* {
    yield* subInvites(call, await request);
  }

  $async.Stream<$0.HIITActivity> createDuoHIIT_Pre($grpc.ServiceCall call,
      $async.Future<$0.CreateDuoHIITRequest> request) async* {
    yield* createDuoHIIT(call, await request);
  }

  $async.Stream<$0.HIITActivity> joinDuoHIIT_Pre($grpc.ServiceCall call,
      $async.Future<$0.JoinDuoHIITRequest> request) async* {
    yield* joinDuoHIIT(call, await request);
  }

  $async.Future<$0.Empty> hIITIntervalComplete_Pre(
      $grpc.ServiceCall call, $async.Future<$0.HIITRequest> request) async {
    return hIITIntervalComplete(call, await request);
  }

  $async.Future<$0.Empty> hIITRoutineComplete_Pre(
      $grpc.ServiceCall call, $async.Future<$0.HIITRequest> request) async {
    return hIITRoutineComplete(call, await request);
  }

  $async.Future<$0.Empty> duoHIITSelectRoutine_Pre(
      $grpc.ServiceCall call, $async.Future<$0.HIITRequest> request) async {
    return duoHIITSelectRoutine(call, await request);
  }

  $async.Future<$0.Empty> hIITWinnerSelectRoutine_Pre(
      $grpc.ServiceCall call, $async.Future<$0.HIITRequest> request) async {
    return hIITWinnerSelectRoutine(call, await request);
  }

  $async.Stream<$0.Data> sub($grpc.ServiceCall call, $0.RoutineChange request);
  $async.Future<$0.Empty> pub($grpc.ServiceCall call, $0.DataSession request);
  $async.Stream<$0.WaitingRoomResponse> createWaitingRoom(
      $grpc.ServiceCall call, $0.CreateWaitingRoomRequest request);
  $async.Stream<$0.WaitingRoomResponse> joinWaitingRoom(
      $grpc.ServiceCall call, $0.WaitingRoomRequest request);
  $async.Future<$0.Empty> startWaitingRoom(
      $grpc.ServiceCall call, $0.StartWaitingRoomRequest request);
  $async.Future<$0.Empty> notifyInvites(
      $grpc.ServiceCall call, $0.InviteWaitingRoomRequest request);
  $async.Stream<$0.InviteWaitingRoomRequest> subInvites(
      $grpc.ServiceCall call, $0.WorkoutUser request);
  $async.Stream<$0.HIITActivity> createDuoHIIT(
      $grpc.ServiceCall call, $0.CreateDuoHIITRequest request);
  $async.Stream<$0.HIITActivity> joinDuoHIIT(
      $grpc.ServiceCall call, $0.JoinDuoHIITRequest request);
  $async.Future<$0.Empty> hIITIntervalComplete(
      $grpc.ServiceCall call, $0.HIITRequest request);
  $async.Future<$0.Empty> hIITRoutineComplete(
      $grpc.ServiceCall call, $0.HIITRequest request);
  $async.Future<$0.Empty> duoHIITSelectRoutine(
      $grpc.ServiceCall call, $0.HIITRequest request);
  $async.Future<$0.Empty> hIITWinnerSelectRoutine(
      $grpc.ServiceCall call, $0.HIITRequest request);
}
