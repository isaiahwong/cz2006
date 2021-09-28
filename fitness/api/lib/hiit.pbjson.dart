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
  ],
};

/// Descriptor for `Data`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dataDescriptor = $convert.base64Decode('CgREYXRhEhQKBXN0YXRlGAEgASgJUgVzdGF0ZRIUCgVjb3VudBgCIAEoBVIFY291bnQ=');
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
@$core.Deprecated('Use pingDescriptor instead')
const Ping$json = const {
  '1': 'Ping',
};

/// Descriptor for `Ping`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pingDescriptor = $convert.base64Decode('CgRQaW5n');
@$core.Deprecated('Use sessionDescriptor instead')
const Session$json = const {
  '1': 'Session',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'topic', '3': 2, '4': 1, '5': 9, '10': 'topic'},
  ],
};

/// Descriptor for `Session`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sessionDescriptor = $convert.base64Decode('CgdTZXNzaW9uEg4KAmlkGAEgASgJUgJpZBIUCgV0b3BpYxgCIAEoCVIFdG9waWM=');
