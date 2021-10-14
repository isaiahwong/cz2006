///
//  Generated code. Do not modify.
//  source: hiit.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = const {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor = $convert.base64Decode('CgVFbXB0eQ==');
@$core.Deprecated('Use dataDescriptor instead')
const Data$json = const {
  '1': 'Data',
  '2': const [
    const {'1': 'state', '3': 1, '4': 1, '5': 9, '10': 'state'},
    const {'1': 'count', '3': 2, '4': 1, '5': 5, '10': 'count'},
    const {'1': 'interval', '3': 3, '4': 1, '5': 9, '10': 'interval'},
  ],
};

/// Descriptor for `Data`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dataDescriptor = $convert.base64Decode('CgREYXRhEhQKBXN0YXRlGAEgASgJUgVzdGF0ZRIUCgVjb3VudBgCIAEoBVIFY291bnQSGgoIaW50ZXJ2YWwYAyABKAlSCGludGVydmFs');
@$core.Deprecated('Use dataSessionDescriptor instead')
const DataSession$json = const {
  '1': 'DataSession',
  '2': const [
    const {'1': 'data', '3': 1, '4': 1, '5': 11, '6': '.hiit.Data', '10': 'data'},
    const {'1': 'session', '3': 2, '4': 1, '5': 11, '6': '.hiit.Session', '10': 'session'},
  ],
};

/// Descriptor for `DataSession`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dataSessionDescriptor = $convert.base64Decode('CgtEYXRhU2Vzc2lvbhIeCgRkYXRhGAEgASgLMgouaGlpdC5EYXRhUgRkYXRhEicKB3Nlc3Npb24YAiABKAsyDS5oaWl0LlNlc3Npb25SB3Nlc3Npb24=');
@$core.Deprecated('Use routineChangeDescriptor instead')
const RoutineChange$json = const {
  '1': 'RoutineChange',
  '2': const [
    const {'1': 'routine', '3': 1, '4': 1, '5': 9, '10': 'routine'},
  ],
};

/// Descriptor for `RoutineChange`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List routineChangeDescriptor = $convert.base64Decode('Cg1Sb3V0aW5lQ2hhbmdlEhgKB3JvdXRpbmUYASABKAlSB3JvdXRpbmU=');
@$core.Deprecated('Use sessionDescriptor instead')
const Session$json = const {
  '1': 'Session',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'exercise', '3': 2, '4': 1, '5': 9, '10': 'exercise'},
  ],
};

/// Descriptor for `Session`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sessionDescriptor = $convert.base64Decode('CgdTZXNzaW9uEg4KAmlkGAEgASgJUgJpZBIaCghleGVyY2lzZRgCIAEoCVIIZXhlcmNpc2U=');
@$core.Deprecated('Use workoutUserDescriptor instead')
const WorkoutUser$json = const {
  '1': 'WorkoutUser',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'score', '3': 4, '4': 1, '5': 5, '10': 'score'},
  ],
};

/// Descriptor for `WorkoutUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List workoutUserDescriptor = $convert.base64Decode('CgtXb3Jrb3V0VXNlchIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIUCgVlbWFpbBgDIAEoCVIFZW1haWwSFAoFc2NvcmUYBCABKAVSBXNjb3Jl');
@$core.Deprecated('Use createWaitingRoomRequestDescriptor instead')
const CreateWaitingRoomRequest$json = const {
  '1': 'CreateWaitingRoomRequest',
  '2': const [
    const {'1': 'host', '3': 1, '4': 1, '5': 11, '6': '.hiit.WorkoutUser', '10': 'host'},
    const {'1': 'workout', '3': 2, '4': 1, '5': 9, '10': 'workout'},
  ],
};

/// Descriptor for `CreateWaitingRoomRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createWaitingRoomRequestDescriptor = $convert.base64Decode('ChhDcmVhdGVXYWl0aW5nUm9vbVJlcXVlc3QSJQoEaG9zdBgBIAEoCzIRLmhpaXQuV29ya291dFVzZXJSBGhvc3QSGAoHd29ya291dBgCIAEoCVIHd29ya291dA==');
@$core.Deprecated('Use waitingRoomRequestDescriptor instead')
const WaitingRoomRequest$json = const {
  '1': 'WaitingRoomRequest',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.hiit.WorkoutUser', '10': 'user'},
    const {'1': 'workout', '3': 2, '4': 1, '5': 9, '10': 'workout'},
  ],
};

/// Descriptor for `WaitingRoomRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List waitingRoomRequestDescriptor = $convert.base64Decode('ChJXYWl0aW5nUm9vbVJlcXVlc3QSJQoEdXNlchgBIAEoCzIRLmhpaXQuV29ya291dFVzZXJSBHVzZXISGAoHd29ya291dBgCIAEoCVIHd29ya291dA==');
@$core.Deprecated('Use waitingRoomResponseDescriptor instead')
const WaitingRoomResponse$json = const {
  '1': 'WaitingRoomResponse',
  '2': const [
    const {'1': 'host', '3': 1, '4': 1, '5': 11, '6': '.hiit.WorkoutUser', '10': 'host'},
    const {'1': 'users', '3': 2, '4': 3, '5': 11, '6': '.hiit.WorkoutUser', '10': 'users'},
    const {'1': 'start', '3': 3, '4': 1, '5': 8, '10': 'start'},
  ],
};

/// Descriptor for `WaitingRoomResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List waitingRoomResponseDescriptor = $convert.base64Decode('ChNXYWl0aW5nUm9vbVJlc3BvbnNlEiUKBGhvc3QYASABKAsyES5oaWl0LldvcmtvdXRVc2VyUgRob3N0EicKBXVzZXJzGAIgAygLMhEuaGlpdC5Xb3Jrb3V0VXNlclIFdXNlcnMSFAoFc3RhcnQYAyABKAhSBXN0YXJ0');
@$core.Deprecated('Use inviteWaitingRoomRequestDescriptor instead')
const InviteWaitingRoomRequest$json = const {
  '1': 'InviteWaitingRoomRequest',
  '2': const [
    const {'1': 'from', '3': 1, '4': 1, '5': 11, '6': '.hiit.WorkoutUser', '10': 'from'},
    const {'1': 'to', '3': 2, '4': 1, '5': 11, '6': '.hiit.WorkoutUser', '10': 'to'},
    const {'1': 'workout', '3': 3, '4': 1, '5': 9, '10': 'workout'},
  ],
};

/// Descriptor for `InviteWaitingRoomRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inviteWaitingRoomRequestDescriptor = $convert.base64Decode('ChhJbnZpdGVXYWl0aW5nUm9vbVJlcXVlc3QSJQoEZnJvbRgBIAEoCzIRLmhpaXQuV29ya291dFVzZXJSBGZyb20SIQoCdG8YAiABKAsyES5oaWl0LldvcmtvdXRVc2VyUgJ0bxIYCgd3b3Jrb3V0GAMgASgJUgd3b3Jrb3V0');
@$core.Deprecated('Use startWaitingRoomRequestDescriptor instead')
const StartWaitingRoomRequest$json = const {
  '1': 'StartWaitingRoomRequest',
  '2': const [
    const {'1': 'host', '3': 1, '4': 1, '5': 11, '6': '.hiit.WorkoutUser', '10': 'host'},
    const {'1': 'workout', '3': 3, '4': 1, '5': 9, '10': 'workout'},
  ],
};

/// Descriptor for `StartWaitingRoomRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startWaitingRoomRequestDescriptor = $convert.base64Decode('ChdTdGFydFdhaXRpbmdSb29tUmVxdWVzdBIlCgRob3N0GAEgASgLMhEuaGlpdC5Xb3Jrb3V0VXNlclIEaG9zdBIYCgd3b3Jrb3V0GAMgASgJUgd3b3Jrb3V0');
@$core.Deprecated('Use createDuoHIITRequestDescriptor instead')
const CreateDuoHIITRequest$json = const {
  '1': 'CreateDuoHIITRequest',
  '2': const [
    const {'1': 'host', '3': 1, '4': 1, '5': 11, '6': '.hiit.WorkoutUser', '10': 'host'},
    const {'1': 'hiit', '3': 2, '4': 1, '5': 9, '10': 'hiit'},
  ],
};

/// Descriptor for `CreateDuoHIITRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createDuoHIITRequestDescriptor = $convert.base64Decode('ChRDcmVhdGVEdW9ISUlUUmVxdWVzdBIlCgRob3N0GAEgASgLMhEuaGlpdC5Xb3Jrb3V0VXNlclIEaG9zdBISCgRoaWl0GAIgASgJUgRoaWl0');
@$core.Deprecated('Use joinDuoHIITRequestDescriptor instead')
const JoinDuoHIITRequest$json = const {
  '1': 'JoinDuoHIITRequest',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.hiit.WorkoutUser', '10': 'user'},
    const {'1': 'hiit', '3': 2, '4': 1, '5': 9, '10': 'hiit'},
  ],
};

/// Descriptor for `JoinDuoHIITRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List joinDuoHIITRequestDescriptor = $convert.base64Decode('ChJKb2luRHVvSElJVFJlcXVlc3QSJQoEdXNlchgBIAEoCzIRLmhpaXQuV29ya291dFVzZXJSBHVzZXISEgoEaGlpdBgCIAEoCVIEaGlpdA==');
@$core.Deprecated('Use hIITActivityDescriptor instead')
const HIITActivity$json = const {
  '1': 'HIITActivity',
  '2': const [
    const {'1': 'hiit', '3': 1, '4': 1, '5': 9, '10': 'hiit'},
    const {'1': 'user', '3': 2, '4': 1, '5': 11, '6': '.hiit.WorkoutUser', '10': 'user'},
    const {'1': 'routine', '3': 3, '4': 1, '5': 11, '6': '.hiit.HIITRoutine', '10': 'routine'},
    const {'1': 'type', '3': 4, '4': 1, '5': 14, '6': '.hiit.HIITActivity.Type', '10': 'type'},
    const {'1': 'winner', '3': 5, '4': 1, '5': 11, '6': '.hiit.WorkoutUser', '10': 'winner'},
  ],
  '4': const [HIITActivity_Type$json],
};

@$core.Deprecated('Use hIITActivityDescriptor instead')
const HIITActivity_Type$json = const {
  '1': 'Type',
  '2': const [
    const {'1': 'UNKNOWN', '2': 0},
    const {'1': 'ROUTINE_CHANGE', '2': 1},
    const {'1': 'WINNER', '2': 2},
  ],
};

/// Descriptor for `HIITActivity`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hIITActivityDescriptor = $convert.base64Decode('CgxISUlUQWN0aXZpdHkSEgoEaGlpdBgBIAEoCVIEaGlpdBIlCgR1c2VyGAIgASgLMhEuaGlpdC5Xb3Jrb3V0VXNlclIEdXNlchIrCgdyb3V0aW5lGAMgASgLMhEuaGlpdC5ISUlUUm91dGluZVIHcm91dGluZRIrCgR0eXBlGAQgASgOMhcuaGlpdC5ISUlUQWN0aXZpdHkuVHlwZVIEdHlwZRIpCgZ3aW5uZXIYBSABKAsyES5oaWl0LldvcmtvdXRVc2VyUgZ3aW5uZXIiMwoEVHlwZRILCgdVTktOT1dOEAASEgoOUk9VVElORV9DSEFOR0UQARIKCgZXSU5ORVIQAg==');
@$core.Deprecated('Use hIITRoutineCompleteDescriptor instead')
const HIITRoutineComplete$json = const {
  '1': 'HIITRoutineComplete',
};

/// Descriptor for `HIITRoutineComplete`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hIITRoutineCompleteDescriptor = $convert.base64Decode('ChNISUlUUm91dGluZUNvbXBsZXRl');
@$core.Deprecated('Use hIITRoutineIntervalDescriptor instead')
const HIITRoutineInterval$json = const {
  '1': 'HIITRoutineInterval',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `HIITRoutineInterval`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hIITRoutineIntervalDescriptor = $convert.base64Decode('ChNISUlUUm91dGluZUludGVydmFsEg4KAmlkGAEgASgJUgJpZA==');
@$core.Deprecated('Use hIITRoutineDescriptor instead')
const HIITRoutine$json = const {
  '1': 'HIITRoutine',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'exercise', '3': 2, '4': 1, '5': 9, '10': 'exercise'},
    const {'1': 'interval', '3': 3, '4': 1, '5': 11, '6': '.hiit.HIITRoutineInterval', '10': 'interval'},
  ],
};

/// Descriptor for `HIITRoutine`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hIITRoutineDescriptor = $convert.base64Decode('CgtISUlUUm91dGluZRIOCgJpZBgBIAEoCVICaWQSGgoIZXhlcmNpc2UYAiABKAlSCGV4ZXJjaXNlEjUKCGludGVydmFsGAMgASgLMhkuaGlpdC5ISUlUUm91dGluZUludGVydmFsUghpbnRlcnZhbA==');
@$core.Deprecated('Use hIITSelectRoutineRequestDescriptor instead')
const HIITSelectRoutineRequest$json = const {
  '1': 'HIITSelectRoutineRequest',
  '2': const [
    const {'1': 'hiit', '3': 1, '4': 1, '5': 9, '10': 'hiit'},
    const {'1': 'user', '3': 2, '4': 1, '5': 11, '6': '.hiit.WorkoutUser', '10': 'user'},
    const {'1': 'routine', '3': 3, '4': 1, '5': 11, '6': '.hiit.HIITRoutine', '10': 'routine'},
  ],
};

/// Descriptor for `HIITSelectRoutineRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hIITSelectRoutineRequestDescriptor = $convert.base64Decode('ChhISUlUU2VsZWN0Um91dGluZVJlcXVlc3QSEgoEaGlpdBgBIAEoCVIEaGlpdBIlCgR1c2VyGAIgASgLMhEuaGlpdC5Xb3Jrb3V0VXNlclIEdXNlchIrCgdyb3V0aW5lGAMgASgLMhEuaGlpdC5ISUlUUm91dGluZVIHcm91dGluZQ==');
