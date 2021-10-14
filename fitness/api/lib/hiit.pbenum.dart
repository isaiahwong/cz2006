///
//  Generated code. Do not modify.
//  source: hiit.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class HIITActivity_Type extends $pb.ProtobufEnum {
  static const HIITActivity_Type UNKNOWN = HIITActivity_Type._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UNKNOWN');
  static const HIITActivity_Type ROUTINE_CHANGE = HIITActivity_Type._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ROUTINE_CHANGE');
  static const HIITActivity_Type WINNER = HIITActivity_Type._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'WINNER');

  static const $core.List<HIITActivity_Type> values = <HIITActivity_Type> [
    UNKNOWN,
    ROUTINE_CHANGE,
    WINNER,
  ];

  static final $core.Map<$core.int, HIITActivity_Type> _byValue = $pb.ProtobufEnum.initByValue(values);
  static HIITActivity_Type? valueOf($core.int value) => _byValue[value];

  const HIITActivity_Type._($core.int v, $core.String n) : super(v, n);
}

