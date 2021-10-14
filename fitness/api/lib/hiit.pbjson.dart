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
@$core.Deprecated('Use hIITUserDescriptor instead')
const HIITUser$json = const {
  '1': 'HIITUser',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `HIITUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hIITUserDescriptor = $convert.base64Decode('CghISUlUVXNlchIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIUCgVlbWFpbBgDIAEoCVIFZW1haWw=');
@$core.Deprecated('Use createWaitingRoomRequestDescriptor instead')
const CreateWaitingRoomRequest$json = const {
  '1': 'CreateWaitingRoomRequest',
  '2': const [
    const {'1': 'host', '3': 1, '4': 1, '5': 11, '6': '.hiit.HIITUser', '10': 'host'},
    const {'1': 'hiit', '3': 2, '4': 1, '5': 9, '10': 'hiit'},
  ],
};

/// Descriptor for `CreateWaitingRoomRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createWaitingRoomRequestDescriptor = $convert.base64Decode('ChhDcmVhdGVXYWl0aW5nUm9vbVJlcXVlc3QSIgoEaG9zdBgBIAEoCzIOLmhpaXQuSElJVFVzZXJSBGhvc3QSEgoEaGlpdBgCIAEoCVIEaGlpdA==');
@$core.Deprecated('Use waitingRoomRequestDescriptor instead')
const WaitingRoomRequest$json = const {
  '1': 'WaitingRoomRequest',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.hiit.HIITUser', '10': 'user'},
    const {'1': 'hiit', '3': 2, '4': 1, '5': 9, '10': 'hiit'},
  ],
};

/// Descriptor for `WaitingRoomRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List waitingRoomRequestDescriptor = $convert.base64Decode('ChJXYWl0aW5nUm9vbVJlcXVlc3QSIgoEdXNlchgBIAEoCzIOLmhpaXQuSElJVFVzZXJSBHVzZXISEgoEaGlpdBgCIAEoCVIEaGlpdA==');
@$core.Deprecated('Use waitingRoomResponseDescriptor instead')
const WaitingRoomResponse$json = const {
  '1': 'WaitingRoomResponse',
  '2': const [
    const {'1': 'host', '3': 1, '4': 1, '5': 11, '6': '.hiit.HIITUser', '10': 'host'},
    const {'1': 'users', '3': 2, '4': 3, '5': 11, '6': '.hiit.HIITUser', '10': 'users'},
    const {'1': 'start', '3': 3, '4': 1, '5': 8, '10': 'start'},
  ],
};

/// Descriptor for `WaitingRoomResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List waitingRoomResponseDescriptor = $convert.base64Decode('ChNXYWl0aW5nUm9vbVJlc3BvbnNlEiIKBGhvc3QYASABKAsyDi5oaWl0LkhJSVRVc2VyUgRob3N0EiQKBXVzZXJzGAIgAygLMg4uaGlpdC5ISUlUVXNlclIFdXNlcnMSFAoFc3RhcnQYAyABKAhSBXN0YXJ0');
@$core.Deprecated('Use inviteWaitingRoomRequestDescriptor instead')
const InviteWaitingRoomRequest$json = const {
  '1': 'InviteWaitingRoomRequest',
  '2': const [
    const {'1': 'from', '3': 1, '4': 1, '5': 11, '6': '.hiit.HIITUser', '10': 'from'},
    const {'1': 'to', '3': 2, '4': 1, '5': 11, '6': '.hiit.HIITUser', '10': 'to'},
    const {'1': 'hiit', '3': 3, '4': 1, '5': 9, '10': 'hiit'},
  ],
};

/// Descriptor for `InviteWaitingRoomRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inviteWaitingRoomRequestDescriptor = $convert.base64Decode('ChhJbnZpdGVXYWl0aW5nUm9vbVJlcXVlc3QSIgoEZnJvbRgBIAEoCzIOLmhpaXQuSElJVFVzZXJSBGZyb20SHgoCdG8YAiABKAsyDi5oaWl0LkhJSVRVc2VyUgJ0bxISCgRoaWl0GAMgASgJUgRoaWl0');
