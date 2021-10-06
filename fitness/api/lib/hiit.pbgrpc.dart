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

  HIITServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$0.Data> sub($async.Stream<$0.RoutineChange> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$sub, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> pub($0.DataSession request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$pub, request, options: options);
  }
}

abstract class HIITServiceBase extends $grpc.Service {
  $core.String get $name => 'hiit.HIITService';

  HIITServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.RoutineChange, $0.Data>(
        'Sub',
        sub,
        true,
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
  }

  $async.Future<$0.Empty> pub_Pre(
      $grpc.ServiceCall call, $async.Future<$0.DataSession> request) async {
    return pub(call, await request);
  }

  $async.Stream<$0.Data> sub(
      $grpc.ServiceCall call, $async.Stream<$0.RoutineChange> request);
  $async.Future<$0.Empty> pub($grpc.ServiceCall call, $0.DataSession request);
}
