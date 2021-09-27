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
  static final _$join = $grpc.ClientMethod<$0.Session, $0.Empty>(
      '/hiit.HIITService/Join',
      ($0.Session value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));

  HIITServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$0.Empty> join($0.Session request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$join, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class HIITServiceBase extends $grpc.Service {
  $core.String get $name => 'hiit.HIITService';

  HIITServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Session, $0.Empty>(
        'Join',
        join_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.Session.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
  }

  $async.Stream<$0.Empty> join_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Session> request) async* {
    yield* join(call, await request);
  }

  $async.Stream<$0.Empty> join($grpc.ServiceCall call, $0.Session request);
}
