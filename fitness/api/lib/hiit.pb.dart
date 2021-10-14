///
//  Generated code. Do not modify.
//  source: hiit.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Empty extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Empty', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'hiit'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  Empty._() : super();
  factory Empty() => create();
  factory Empty.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Empty.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Empty clone() => Empty()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Empty copyWith(void Function(Empty) updates) => super.copyWith((message) => updates(message as Empty)) as Empty; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Empty create() => Empty._();
  Empty createEmptyInstance() => create();
  static $pb.PbList<Empty> createRepeated() => $pb.PbList<Empty>();
  @$core.pragma('dart2js:noInline')
  static Empty getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Empty>(create);
  static Empty? _defaultInstance;
}

class Data extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Data', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'hiit'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'count', $pb.PbFieldType.O3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'interval')
    ..hasRequiredFields = false
  ;

  Data._() : super();
  factory Data({
    $core.String? state,
    $core.int? count,
    $core.String? interval,
  }) {
    final _result = create();
    if (state != null) {
      _result.state = state;
    }
    if (count != null) {
      _result.count = count;
    }
    if (interval != null) {
      _result.interval = interval;
    }
    return _result;
  }
  factory Data.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Data.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Data clone() => Data()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Data copyWith(void Function(Data) updates) => super.copyWith((message) => updates(message as Data)) as Data; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Data create() => Data._();
  Data createEmptyInstance() => create();
  static $pb.PbList<Data> createRepeated() => $pb.PbList<Data>();
  @$core.pragma('dart2js:noInline')
  static Data getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Data>(create);
  static Data? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get state => $_getSZ(0);
  @$pb.TagNumber(1)
  set state($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasState() => $_has(0);
  @$pb.TagNumber(1)
  void clearState() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get count => $_getIZ(1);
  @$pb.TagNumber(2)
  set count($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearCount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get interval => $_getSZ(2);
  @$pb.TagNumber(3)
  set interval($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasInterval() => $_has(2);
  @$pb.TagNumber(3)
  void clearInterval() => clearField(3);
}

class DataSession extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DataSession', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'hiit'), createEmptyInstance: create)
    ..aOM<Data>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data', subBuilder: Data.create)
    ..aOM<Session>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'session', subBuilder: Session.create)
    ..hasRequiredFields = false
  ;

  DataSession._() : super();
  factory DataSession({
    Data? data,
    Session? session,
  }) {
    final _result = create();
    if (data != null) {
      _result.data = data;
    }
    if (session != null) {
      _result.session = session;
    }
    return _result;
  }
  factory DataSession.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DataSession.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DataSession clone() => DataSession()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DataSession copyWith(void Function(DataSession) updates) => super.copyWith((message) => updates(message as DataSession)) as DataSession; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DataSession create() => DataSession._();
  DataSession createEmptyInstance() => create();
  static $pb.PbList<DataSession> createRepeated() => $pb.PbList<DataSession>();
  @$core.pragma('dart2js:noInline')
  static DataSession getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DataSession>(create);
  static DataSession? _defaultInstance;

  @$pb.TagNumber(1)
  Data get data => $_getN(0);
  @$pb.TagNumber(1)
  set data(Data v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => clearField(1);
  @$pb.TagNumber(1)
  Data ensureData() => $_ensure(0);

  @$pb.TagNumber(2)
  Session get session => $_getN(1);
  @$pb.TagNumber(2)
  set session(Session v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasSession() => $_has(1);
  @$pb.TagNumber(2)
  void clearSession() => clearField(2);
  @$pb.TagNumber(2)
  Session ensureSession() => $_ensure(1);
}

class RoutineChange extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RoutineChange', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'hiit'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'routine')
    ..hasRequiredFields = false
  ;

  RoutineChange._() : super();
  factory RoutineChange({
    $core.String? routine,
  }) {
    final _result = create();
    if (routine != null) {
      _result.routine = routine;
    }
    return _result;
  }
  factory RoutineChange.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RoutineChange.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RoutineChange clone() => RoutineChange()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RoutineChange copyWith(void Function(RoutineChange) updates) => super.copyWith((message) => updates(message as RoutineChange)) as RoutineChange; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RoutineChange create() => RoutineChange._();
  RoutineChange createEmptyInstance() => create();
  static $pb.PbList<RoutineChange> createRepeated() => $pb.PbList<RoutineChange>();
  @$core.pragma('dart2js:noInline')
  static RoutineChange getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RoutineChange>(create);
  static RoutineChange? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get routine => $_getSZ(0);
  @$pb.TagNumber(1)
  set routine($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRoutine() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoutine() => clearField(1);
}

class Session extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Session', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'hiit'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'exercise')
    ..hasRequiredFields = false
  ;

  Session._() : super();
  factory Session({
    $core.String? id,
    $core.String? exercise,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (exercise != null) {
      _result.exercise = exercise;
    }
    return _result;
  }
  factory Session.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Session.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Session clone() => Session()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Session copyWith(void Function(Session) updates) => super.copyWith((message) => updates(message as Session)) as Session; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Session create() => Session._();
  Session createEmptyInstance() => create();
  static $pb.PbList<Session> createRepeated() => $pb.PbList<Session>();
  @$core.pragma('dart2js:noInline')
  static Session getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Session>(create);
  static Session? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get exercise => $_getSZ(1);
  @$pb.TagNumber(2)
  set exercise($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasExercise() => $_has(1);
  @$pb.TagNumber(2)
  void clearExercise() => clearField(2);
}

class WorkoutUser extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WorkoutUser', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'hiit'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..hasRequiredFields = false
  ;

  WorkoutUser._() : super();
  factory WorkoutUser({
    $core.String? id,
    $core.String? name,
    $core.String? email,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (email != null) {
      _result.email = email;
    }
    return _result;
  }
  factory WorkoutUser.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WorkoutUser.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WorkoutUser clone() => WorkoutUser()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WorkoutUser copyWith(void Function(WorkoutUser) updates) => super.copyWith((message) => updates(message as WorkoutUser)) as WorkoutUser; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WorkoutUser create() => WorkoutUser._();
  WorkoutUser createEmptyInstance() => create();
  static $pb.PbList<WorkoutUser> createRepeated() => $pb.PbList<WorkoutUser>();
  @$core.pragma('dart2js:noInline')
  static WorkoutUser getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WorkoutUser>(create);
  static WorkoutUser? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => clearField(3);
}

class CreateWaitingRoomRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateWaitingRoomRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'hiit'), createEmptyInstance: create)
    ..aOM<WorkoutUser>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'host', subBuilder: WorkoutUser.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'workout')
    ..hasRequiredFields = false
  ;

  CreateWaitingRoomRequest._() : super();
  factory CreateWaitingRoomRequest({
    WorkoutUser? host,
    $core.String? workout,
  }) {
    final _result = create();
    if (host != null) {
      _result.host = host;
    }
    if (workout != null) {
      _result.workout = workout;
    }
    return _result;
  }
  factory CreateWaitingRoomRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateWaitingRoomRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateWaitingRoomRequest clone() => CreateWaitingRoomRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateWaitingRoomRequest copyWith(void Function(CreateWaitingRoomRequest) updates) => super.copyWith((message) => updates(message as CreateWaitingRoomRequest)) as CreateWaitingRoomRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateWaitingRoomRequest create() => CreateWaitingRoomRequest._();
  CreateWaitingRoomRequest createEmptyInstance() => create();
  static $pb.PbList<CreateWaitingRoomRequest> createRepeated() => $pb.PbList<CreateWaitingRoomRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateWaitingRoomRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateWaitingRoomRequest>(create);
  static CreateWaitingRoomRequest? _defaultInstance;

  @$pb.TagNumber(1)
  WorkoutUser get host => $_getN(0);
  @$pb.TagNumber(1)
  set host(WorkoutUser v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasHost() => $_has(0);
  @$pb.TagNumber(1)
  void clearHost() => clearField(1);
  @$pb.TagNumber(1)
  WorkoutUser ensureHost() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get workout => $_getSZ(1);
  @$pb.TagNumber(2)
  set workout($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasWorkout() => $_has(1);
  @$pb.TagNumber(2)
  void clearWorkout() => clearField(2);
}

class WaitingRoomRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WaitingRoomRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'hiit'), createEmptyInstance: create)
    ..aOM<WorkoutUser>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'user', subBuilder: WorkoutUser.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'workout')
    ..hasRequiredFields = false
  ;

  WaitingRoomRequest._() : super();
  factory WaitingRoomRequest({
    WorkoutUser? user,
    $core.String? workout,
  }) {
    final _result = create();
    if (user != null) {
      _result.user = user;
    }
    if (workout != null) {
      _result.workout = workout;
    }
    return _result;
  }
  factory WaitingRoomRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WaitingRoomRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WaitingRoomRequest clone() => WaitingRoomRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WaitingRoomRequest copyWith(void Function(WaitingRoomRequest) updates) => super.copyWith((message) => updates(message as WaitingRoomRequest)) as WaitingRoomRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WaitingRoomRequest create() => WaitingRoomRequest._();
  WaitingRoomRequest createEmptyInstance() => create();
  static $pb.PbList<WaitingRoomRequest> createRepeated() => $pb.PbList<WaitingRoomRequest>();
  @$core.pragma('dart2js:noInline')
  static WaitingRoomRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WaitingRoomRequest>(create);
  static WaitingRoomRequest? _defaultInstance;

  @$pb.TagNumber(1)
  WorkoutUser get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(WorkoutUser v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => clearField(1);
  @$pb.TagNumber(1)
  WorkoutUser ensureUser() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get workout => $_getSZ(1);
  @$pb.TagNumber(2)
  set workout($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasWorkout() => $_has(1);
  @$pb.TagNumber(2)
  void clearWorkout() => clearField(2);
}

class WaitingRoomResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WaitingRoomResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'hiit'), createEmptyInstance: create)
    ..aOM<WorkoutUser>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'host', subBuilder: WorkoutUser.create)
    ..pc<WorkoutUser>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'users', $pb.PbFieldType.PM, subBuilder: WorkoutUser.create)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'start')
    ..hasRequiredFields = false
  ;

  WaitingRoomResponse._() : super();
  factory WaitingRoomResponse({
    WorkoutUser? host,
    $core.Iterable<WorkoutUser>? users,
    $core.bool? start,
  }) {
    final _result = create();
    if (host != null) {
      _result.host = host;
    }
    if (users != null) {
      _result.users.addAll(users);
    }
    if (start != null) {
      _result.start = start;
    }
    return _result;
  }
  factory WaitingRoomResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WaitingRoomResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WaitingRoomResponse clone() => WaitingRoomResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WaitingRoomResponse copyWith(void Function(WaitingRoomResponse) updates) => super.copyWith((message) => updates(message as WaitingRoomResponse)) as WaitingRoomResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WaitingRoomResponse create() => WaitingRoomResponse._();
  WaitingRoomResponse createEmptyInstance() => create();
  static $pb.PbList<WaitingRoomResponse> createRepeated() => $pb.PbList<WaitingRoomResponse>();
  @$core.pragma('dart2js:noInline')
  static WaitingRoomResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WaitingRoomResponse>(create);
  static WaitingRoomResponse? _defaultInstance;

  @$pb.TagNumber(1)
  WorkoutUser get host => $_getN(0);
  @$pb.TagNumber(1)
  set host(WorkoutUser v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasHost() => $_has(0);
  @$pb.TagNumber(1)
  void clearHost() => clearField(1);
  @$pb.TagNumber(1)
  WorkoutUser ensureHost() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<WorkoutUser> get users => $_getList(1);

  @$pb.TagNumber(3)
  $core.bool get start => $_getBF(2);
  @$pb.TagNumber(3)
  set start($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStart() => $_has(2);
  @$pb.TagNumber(3)
  void clearStart() => clearField(3);
}

class InviteWaitingRoomRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InviteWaitingRoomRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'hiit'), createEmptyInstance: create)
    ..aOM<WorkoutUser>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'from', subBuilder: WorkoutUser.create)
    ..aOM<WorkoutUser>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'to', subBuilder: WorkoutUser.create)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'workout')
    ..hasRequiredFields = false
  ;

  InviteWaitingRoomRequest._() : super();
  factory InviteWaitingRoomRequest({
    WorkoutUser? from,
    WorkoutUser? to,
    $core.String? workout,
  }) {
    final _result = create();
    if (from != null) {
      _result.from = from;
    }
    if (to != null) {
      _result.to = to;
    }
    if (workout != null) {
      _result.workout = workout;
    }
    return _result;
  }
  factory InviteWaitingRoomRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InviteWaitingRoomRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InviteWaitingRoomRequest clone() => InviteWaitingRoomRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InviteWaitingRoomRequest copyWith(void Function(InviteWaitingRoomRequest) updates) => super.copyWith((message) => updates(message as InviteWaitingRoomRequest)) as InviteWaitingRoomRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InviteWaitingRoomRequest create() => InviteWaitingRoomRequest._();
  InviteWaitingRoomRequest createEmptyInstance() => create();
  static $pb.PbList<InviteWaitingRoomRequest> createRepeated() => $pb.PbList<InviteWaitingRoomRequest>();
  @$core.pragma('dart2js:noInline')
  static InviteWaitingRoomRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InviteWaitingRoomRequest>(create);
  static InviteWaitingRoomRequest? _defaultInstance;

  @$pb.TagNumber(1)
  WorkoutUser get from => $_getN(0);
  @$pb.TagNumber(1)
  set from(WorkoutUser v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasFrom() => $_has(0);
  @$pb.TagNumber(1)
  void clearFrom() => clearField(1);
  @$pb.TagNumber(1)
  WorkoutUser ensureFrom() => $_ensure(0);

  @$pb.TagNumber(2)
  WorkoutUser get to => $_getN(1);
  @$pb.TagNumber(2)
  set to(WorkoutUser v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTo() => $_has(1);
  @$pb.TagNumber(2)
  void clearTo() => clearField(2);
  @$pb.TagNumber(2)
  WorkoutUser ensureTo() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get workout => $_getSZ(2);
  @$pb.TagNumber(3)
  set workout($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasWorkout() => $_has(2);
  @$pb.TagNumber(3)
  void clearWorkout() => clearField(3);
}

class StartWaitingRoomRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StartWaitingRoomRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'hiit'), createEmptyInstance: create)
    ..aOM<WorkoutUser>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'host', subBuilder: WorkoutUser.create)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'workout')
    ..hasRequiredFields = false
  ;

  StartWaitingRoomRequest._() : super();
  factory StartWaitingRoomRequest({
    WorkoutUser? host,
    $core.String? workout,
  }) {
    final _result = create();
    if (host != null) {
      _result.host = host;
    }
    if (workout != null) {
      _result.workout = workout;
    }
    return _result;
  }
  factory StartWaitingRoomRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StartWaitingRoomRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StartWaitingRoomRequest clone() => StartWaitingRoomRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StartWaitingRoomRequest copyWith(void Function(StartWaitingRoomRequest) updates) => super.copyWith((message) => updates(message as StartWaitingRoomRequest)) as StartWaitingRoomRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StartWaitingRoomRequest create() => StartWaitingRoomRequest._();
  StartWaitingRoomRequest createEmptyInstance() => create();
  static $pb.PbList<StartWaitingRoomRequest> createRepeated() => $pb.PbList<StartWaitingRoomRequest>();
  @$core.pragma('dart2js:noInline')
  static StartWaitingRoomRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StartWaitingRoomRequest>(create);
  static StartWaitingRoomRequest? _defaultInstance;

  @$pb.TagNumber(1)
  WorkoutUser get host => $_getN(0);
  @$pb.TagNumber(1)
  set host(WorkoutUser v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasHost() => $_has(0);
  @$pb.TagNumber(1)
  void clearHost() => clearField(1);
  @$pb.TagNumber(1)
  WorkoutUser ensureHost() => $_ensure(0);

  @$pb.TagNumber(3)
  $core.String get workout => $_getSZ(1);
  @$pb.TagNumber(3)
  set workout($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(3)
  $core.bool hasWorkout() => $_has(1);
  @$pb.TagNumber(3)
  void clearWorkout() => clearField(3);
}

class HIITRoutine extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HIITRoutine', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'hiit'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'exercise')
    ..hasRequiredFields = false
  ;

  HIITRoutine._() : super();
  factory HIITRoutine({
    $core.String? id,
    $core.String? exercise,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (exercise != null) {
      _result.exercise = exercise;
    }
    return _result;
  }
  factory HIITRoutine.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HIITRoutine.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HIITRoutine clone() => HIITRoutine()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HIITRoutine copyWith(void Function(HIITRoutine) updates) => super.copyWith((message) => updates(message as HIITRoutine)) as HIITRoutine; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HIITRoutine create() => HIITRoutine._();
  HIITRoutine createEmptyInstance() => create();
  static $pb.PbList<HIITRoutine> createRepeated() => $pb.PbList<HIITRoutine>();
  @$core.pragma('dart2js:noInline')
  static HIITRoutine getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HIITRoutine>(create);
  static HIITRoutine? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get exercise => $_getSZ(1);
  @$pb.TagNumber(2)
  set exercise($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasExercise() => $_has(1);
  @$pb.TagNumber(2)
  void clearExercise() => clearField(2);
}

class CreateDuoHIITRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateDuoHIITRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'hiit'), createEmptyInstance: create)
    ..aOM<WorkoutUser>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'host', subBuilder: WorkoutUser.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hiit')
    ..hasRequiredFields = false
  ;

  CreateDuoHIITRequest._() : super();
  factory CreateDuoHIITRequest({
    WorkoutUser? host,
    $core.String? hiit,
  }) {
    final _result = create();
    if (host != null) {
      _result.host = host;
    }
    if (hiit != null) {
      _result.hiit = hiit;
    }
    return _result;
  }
  factory CreateDuoHIITRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateDuoHIITRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateDuoHIITRequest clone() => CreateDuoHIITRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateDuoHIITRequest copyWith(void Function(CreateDuoHIITRequest) updates) => super.copyWith((message) => updates(message as CreateDuoHIITRequest)) as CreateDuoHIITRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateDuoHIITRequest create() => CreateDuoHIITRequest._();
  CreateDuoHIITRequest createEmptyInstance() => create();
  static $pb.PbList<CreateDuoHIITRequest> createRepeated() => $pb.PbList<CreateDuoHIITRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateDuoHIITRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateDuoHIITRequest>(create);
  static CreateDuoHIITRequest? _defaultInstance;

  @$pb.TagNumber(1)
  WorkoutUser get host => $_getN(0);
  @$pb.TagNumber(1)
  set host(WorkoutUser v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasHost() => $_has(0);
  @$pb.TagNumber(1)
  void clearHost() => clearField(1);
  @$pb.TagNumber(1)
  WorkoutUser ensureHost() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get hiit => $_getSZ(1);
  @$pb.TagNumber(2)
  set hiit($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHiit() => $_has(1);
  @$pb.TagNumber(2)
  void clearHiit() => clearField(2);
}

class JoinDuoHIITRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'JoinDuoHIITRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'hiit'), createEmptyInstance: create)
    ..aOM<WorkoutUser>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'user', subBuilder: WorkoutUser.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hiit')
    ..hasRequiredFields = false
  ;

  JoinDuoHIITRequest._() : super();
  factory JoinDuoHIITRequest({
    WorkoutUser? user,
    $core.String? hiit,
  }) {
    final _result = create();
    if (user != null) {
      _result.user = user;
    }
    if (hiit != null) {
      _result.hiit = hiit;
    }
    return _result;
  }
  factory JoinDuoHIITRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory JoinDuoHIITRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  JoinDuoHIITRequest clone() => JoinDuoHIITRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  JoinDuoHIITRequest copyWith(void Function(JoinDuoHIITRequest) updates) => super.copyWith((message) => updates(message as JoinDuoHIITRequest)) as JoinDuoHIITRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static JoinDuoHIITRequest create() => JoinDuoHIITRequest._();
  JoinDuoHIITRequest createEmptyInstance() => create();
  static $pb.PbList<JoinDuoHIITRequest> createRepeated() => $pb.PbList<JoinDuoHIITRequest>();
  @$core.pragma('dart2js:noInline')
  static JoinDuoHIITRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JoinDuoHIITRequest>(create);
  static JoinDuoHIITRequest? _defaultInstance;

  @$pb.TagNumber(1)
  WorkoutUser get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(WorkoutUser v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => clearField(1);
  @$pb.TagNumber(1)
  WorkoutUser ensureUser() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get hiit => $_getSZ(1);
  @$pb.TagNumber(2)
  set hiit($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHiit() => $_has(1);
  @$pb.TagNumber(2)
  void clearHiit() => clearField(2);
}

class ActiveRoutine extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ActiveRoutine', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'hiit'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hiit')
    ..hasRequiredFields = false
  ;

  ActiveRoutine._() : super();
  factory ActiveRoutine({
    $core.String? hiit,
  }) {
    final _result = create();
    if (hiit != null) {
      _result.hiit = hiit;
    }
    return _result;
  }
  factory ActiveRoutine.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ActiveRoutine.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ActiveRoutine clone() => ActiveRoutine()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ActiveRoutine copyWith(void Function(ActiveRoutine) updates) => super.copyWith((message) => updates(message as ActiveRoutine)) as ActiveRoutine; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ActiveRoutine create() => ActiveRoutine._();
  ActiveRoutine createEmptyInstance() => create();
  static $pb.PbList<ActiveRoutine> createRepeated() => $pb.PbList<ActiveRoutine>();
  @$core.pragma('dart2js:noInline')
  static ActiveRoutine getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ActiveRoutine>(create);
  static ActiveRoutine? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get hiit => $_getSZ(0);
  @$pb.TagNumber(1)
  set hiit($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHiit() => $_has(0);
  @$pb.TagNumber(1)
  void clearHiit() => clearField(1);
}

class DuoHIITResult extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DuoHIITResult', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'hiit'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'winner')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'score', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  DuoHIITResult._() : super();
  factory DuoHIITResult({
    $core.String? winner,
    $core.int? score,
  }) {
    final _result = create();
    if (winner != null) {
      _result.winner = winner;
    }
    if (score != null) {
      _result.score = score;
    }
    return _result;
  }
  factory DuoHIITResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DuoHIITResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DuoHIITResult clone() => DuoHIITResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DuoHIITResult copyWith(void Function(DuoHIITResult) updates) => super.copyWith((message) => updates(message as DuoHIITResult)) as DuoHIITResult; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DuoHIITResult create() => DuoHIITResult._();
  DuoHIITResult createEmptyInstance() => create();
  static $pb.PbList<DuoHIITResult> createRepeated() => $pb.PbList<DuoHIITResult>();
  @$core.pragma('dart2js:noInline')
  static DuoHIITResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DuoHIITResult>(create);
  static DuoHIITResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get winner => $_getSZ(0);
  @$pb.TagNumber(1)
  set winner($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWinner() => $_has(0);
  @$pb.TagNumber(1)
  void clearWinner() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get score => $_getIZ(1);
  @$pb.TagNumber(2)
  set score($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasScore() => $_has(1);
  @$pb.TagNumber(2)
  void clearScore() => clearField(2);
}

