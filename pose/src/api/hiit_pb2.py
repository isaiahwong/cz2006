# -*- coding: utf-8 -*-
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: hiit.proto
"""Generated protocol buffer code."""
from google.protobuf import descriptor as _descriptor
from google.protobuf import message as _message
from google.protobuf import reflection as _reflection
from google.protobuf import symbol_database as _symbol_database
# @@protoc_insertion_point(imports)

_sym_db = _symbol_database.Default()




DESCRIPTOR = _descriptor.FileDescriptor(
  name='hiit.proto',
  package='hiit',
  syntax='proto3',
  serialized_options=b'Z\005hiit/',
  create_key=_descriptor._internal_create_key,
  serialized_pb=b'\n\nhiit.proto\x12\x04hiit\"\x07\n\x05\x45mpty\"6\n\x04\x44\x61ta\x12\r\n\x05state\x18\x01 \x01(\t\x12\r\n\x05\x63ount\x18\x02 \x01(\x05\x12\x10\n\x08interval\x18\x03 \x01(\t\"G\n\x0b\x44\x61taSession\x12\x18\n\x04\x64\x61ta\x18\x01 \x01(\x0b\x32\n.hiit.Data\x12\x1e\n\x07session\x18\x02 \x01(\x0b\x32\r.hiit.Session\" \n\rRoutineChange\x12\x0f\n\x07routine\x18\x01 \x01(\t\"\'\n\x07Session\x12\n\n\x02id\x18\x01 \x01(\t\x12\x10\n\x08\x65xercise\x18\x02 \x01(\t\"3\n\x08HIITUser\x12\n\n\x02id\x18\x01 \x01(\t\x12\x0c\n\x04name\x18\x02 \x01(\t\x12\r\n\x05\x65mail\x18\x03 \x01(\t\"F\n\x18\x43reateWaitingRoomRequest\x12\x1c\n\x04host\x18\x01 \x01(\x0b\x32\x0e.hiit.HIITUser\x12\x0c\n\x04hiit\x18\x02 \x01(\t\"@\n\x12WaitingRoomRequest\x12\x1c\n\x04user\x18\x01 \x01(\x0b\x32\x0e.hiit.HIITUser\x12\x0c\n\x04hiit\x18\x02 \x01(\t\"a\n\x13WaitingRoomResponse\x12\x1c\n\x04host\x18\x01 \x01(\x0b\x32\x0e.hiit.HIITUser\x12\x1d\n\x05users\x18\x02 \x03(\x0b\x32\x0e.hiit.HIITUser\x12\r\n\x05start\x18\x03 \x01(\x08\"b\n\x18InviteWaitingRoomRequest\x12\x1c\n\x04\x66rom\x18\x01 \x01(\x0b\x32\x0e.hiit.HIITUser\x12\x1a\n\x02to\x18\x02 \x01(\x0b\x32\x0e.hiit.HIITUser\x12\x0c\n\x04hiit\x18\x03 \x01(\t2\xf8\x02\n\x0bHIITService\x12(\n\x03Sub\x12\x13.hiit.RoutineChange\x1a\n.hiit.Data0\x01\x12%\n\x03Pub\x12\x11.hiit.DataSession\x1a\x0b.hiit.Empty\x12P\n\x11\x43reateWaitingRoom\x12\x1e.hiit.CreateWaitingRoomRequest\x1a\x19.hiit.WaitingRoomResponse0\x01\x12H\n\x0fJoinWaitingRoom\x12\x18.hiit.WaitingRoomRequest\x1a\x19.hiit.WaitingRoomResponse0\x01\x12<\n\rNotifyInvites\x12\x1e.hiit.InviteWaitingRoomRequest\x1a\x0b.hiit.Empty\x12>\n\nSubInvites\x12\x0e.hiit.HIITUser\x1a\x1e.hiit.InviteWaitingRoomRequest0\x01\x42\x07Z\x05hiit/b\x06proto3'
)




_EMPTY = _descriptor.Descriptor(
  name='Empty',
  full_name='hiit.Empty',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=20,
  serialized_end=27,
)


_DATA = _descriptor.Descriptor(
  name='Data',
  full_name='hiit.Data',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='state', full_name='hiit.Data.state', index=0,
      number=1, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='count', full_name='hiit.Data.count', index=1,
      number=2, type=5, cpp_type=1, label=1,
      has_default_value=False, default_value=0,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='interval', full_name='hiit.Data.interval', index=2,
      number=3, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=29,
  serialized_end=83,
)


_DATASESSION = _descriptor.Descriptor(
  name='DataSession',
  full_name='hiit.DataSession',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='data', full_name='hiit.DataSession.data', index=0,
      number=1, type=11, cpp_type=10, label=1,
      has_default_value=False, default_value=None,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='session', full_name='hiit.DataSession.session', index=1,
      number=2, type=11, cpp_type=10, label=1,
      has_default_value=False, default_value=None,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=85,
  serialized_end=156,
)


_ROUTINECHANGE = _descriptor.Descriptor(
  name='RoutineChange',
  full_name='hiit.RoutineChange',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='routine', full_name='hiit.RoutineChange.routine', index=0,
      number=1, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=158,
  serialized_end=190,
)


_SESSION = _descriptor.Descriptor(
  name='Session',
  full_name='hiit.Session',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='id', full_name='hiit.Session.id', index=0,
      number=1, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='exercise', full_name='hiit.Session.exercise', index=1,
      number=2, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=192,
  serialized_end=231,
)


_HIITUSER = _descriptor.Descriptor(
  name='HIITUser',
  full_name='hiit.HIITUser',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='id', full_name='hiit.HIITUser.id', index=0,
      number=1, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='name', full_name='hiit.HIITUser.name', index=1,
      number=2, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='email', full_name='hiit.HIITUser.email', index=2,
      number=3, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=233,
  serialized_end=284,
)


_CREATEWAITINGROOMREQUEST = _descriptor.Descriptor(
  name='CreateWaitingRoomRequest',
  full_name='hiit.CreateWaitingRoomRequest',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='host', full_name='hiit.CreateWaitingRoomRequest.host', index=0,
      number=1, type=11, cpp_type=10, label=1,
      has_default_value=False, default_value=None,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='hiit', full_name='hiit.CreateWaitingRoomRequest.hiit', index=1,
      number=2, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=286,
  serialized_end=356,
)


_WAITINGROOMREQUEST = _descriptor.Descriptor(
  name='WaitingRoomRequest',
  full_name='hiit.WaitingRoomRequest',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='user', full_name='hiit.WaitingRoomRequest.user', index=0,
      number=1, type=11, cpp_type=10, label=1,
      has_default_value=False, default_value=None,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='hiit', full_name='hiit.WaitingRoomRequest.hiit', index=1,
      number=2, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=358,
  serialized_end=422,
)


_WAITINGROOMRESPONSE = _descriptor.Descriptor(
  name='WaitingRoomResponse',
  full_name='hiit.WaitingRoomResponse',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='host', full_name='hiit.WaitingRoomResponse.host', index=0,
      number=1, type=11, cpp_type=10, label=1,
      has_default_value=False, default_value=None,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='users', full_name='hiit.WaitingRoomResponse.users', index=1,
      number=2, type=11, cpp_type=10, label=3,
      has_default_value=False, default_value=[],
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='start', full_name='hiit.WaitingRoomResponse.start', index=2,
      number=3, type=8, cpp_type=7, label=1,
      has_default_value=False, default_value=False,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=424,
  serialized_end=521,
)


_INVITEWAITINGROOMREQUEST = _descriptor.Descriptor(
  name='InviteWaitingRoomRequest',
  full_name='hiit.InviteWaitingRoomRequest',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='from', full_name='hiit.InviteWaitingRoomRequest.from', index=0,
      number=1, type=11, cpp_type=10, label=1,
      has_default_value=False, default_value=None,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='to', full_name='hiit.InviteWaitingRoomRequest.to', index=1,
      number=2, type=11, cpp_type=10, label=1,
      has_default_value=False, default_value=None,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='hiit', full_name='hiit.InviteWaitingRoomRequest.hiit', index=2,
      number=3, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=523,
  serialized_end=621,
)

_DATASESSION.fields_by_name['data'].message_type = _DATA
_DATASESSION.fields_by_name['session'].message_type = _SESSION
_CREATEWAITINGROOMREQUEST.fields_by_name['host'].message_type = _HIITUSER
_WAITINGROOMREQUEST.fields_by_name['user'].message_type = _HIITUSER
_WAITINGROOMRESPONSE.fields_by_name['host'].message_type = _HIITUSER
_WAITINGROOMRESPONSE.fields_by_name['users'].message_type = _HIITUSER
_INVITEWAITINGROOMREQUEST.fields_by_name['from'].message_type = _HIITUSER
_INVITEWAITINGROOMREQUEST.fields_by_name['to'].message_type = _HIITUSER
DESCRIPTOR.message_types_by_name['Empty'] = _EMPTY
DESCRIPTOR.message_types_by_name['Data'] = _DATA
DESCRIPTOR.message_types_by_name['DataSession'] = _DATASESSION
DESCRIPTOR.message_types_by_name['RoutineChange'] = _ROUTINECHANGE
DESCRIPTOR.message_types_by_name['Session'] = _SESSION
DESCRIPTOR.message_types_by_name['HIITUser'] = _HIITUSER
DESCRIPTOR.message_types_by_name['CreateWaitingRoomRequest'] = _CREATEWAITINGROOMREQUEST
DESCRIPTOR.message_types_by_name['WaitingRoomRequest'] = _WAITINGROOMREQUEST
DESCRIPTOR.message_types_by_name['WaitingRoomResponse'] = _WAITINGROOMRESPONSE
DESCRIPTOR.message_types_by_name['InviteWaitingRoomRequest'] = _INVITEWAITINGROOMREQUEST
_sym_db.RegisterFileDescriptor(DESCRIPTOR)

Empty = _reflection.GeneratedProtocolMessageType('Empty', (_message.Message,), {
  'DESCRIPTOR' : _EMPTY,
  '__module__' : 'hiit_pb2'
  # @@protoc_insertion_point(class_scope:hiit.Empty)
  })
_sym_db.RegisterMessage(Empty)

Data = _reflection.GeneratedProtocolMessageType('Data', (_message.Message,), {
  'DESCRIPTOR' : _DATA,
  '__module__' : 'hiit_pb2'
  # @@protoc_insertion_point(class_scope:hiit.Data)
  })
_sym_db.RegisterMessage(Data)

DataSession = _reflection.GeneratedProtocolMessageType('DataSession', (_message.Message,), {
  'DESCRIPTOR' : _DATASESSION,
  '__module__' : 'hiit_pb2'
  # @@protoc_insertion_point(class_scope:hiit.DataSession)
  })
_sym_db.RegisterMessage(DataSession)

RoutineChange = _reflection.GeneratedProtocolMessageType('RoutineChange', (_message.Message,), {
  'DESCRIPTOR' : _ROUTINECHANGE,
  '__module__' : 'hiit_pb2'
  # @@protoc_insertion_point(class_scope:hiit.RoutineChange)
  })
_sym_db.RegisterMessage(RoutineChange)

Session = _reflection.GeneratedProtocolMessageType('Session', (_message.Message,), {
  'DESCRIPTOR' : _SESSION,
  '__module__' : 'hiit_pb2'
  # @@protoc_insertion_point(class_scope:hiit.Session)
  })
_sym_db.RegisterMessage(Session)

HIITUser = _reflection.GeneratedProtocolMessageType('HIITUser', (_message.Message,), {
  'DESCRIPTOR' : _HIITUSER,
  '__module__' : 'hiit_pb2'
  # @@protoc_insertion_point(class_scope:hiit.HIITUser)
  })
_sym_db.RegisterMessage(HIITUser)

CreateWaitingRoomRequest = _reflection.GeneratedProtocolMessageType('CreateWaitingRoomRequest', (_message.Message,), {
  'DESCRIPTOR' : _CREATEWAITINGROOMREQUEST,
  '__module__' : 'hiit_pb2'
  # @@protoc_insertion_point(class_scope:hiit.CreateWaitingRoomRequest)
  })
_sym_db.RegisterMessage(CreateWaitingRoomRequest)

WaitingRoomRequest = _reflection.GeneratedProtocolMessageType('WaitingRoomRequest', (_message.Message,), {
  'DESCRIPTOR' : _WAITINGROOMREQUEST,
  '__module__' : 'hiit_pb2'
  # @@protoc_insertion_point(class_scope:hiit.WaitingRoomRequest)
  })
_sym_db.RegisterMessage(WaitingRoomRequest)

WaitingRoomResponse = _reflection.GeneratedProtocolMessageType('WaitingRoomResponse', (_message.Message,), {
  'DESCRIPTOR' : _WAITINGROOMRESPONSE,
  '__module__' : 'hiit_pb2'
  # @@protoc_insertion_point(class_scope:hiit.WaitingRoomResponse)
  })
_sym_db.RegisterMessage(WaitingRoomResponse)

InviteWaitingRoomRequest = _reflection.GeneratedProtocolMessageType('InviteWaitingRoomRequest', (_message.Message,), {
  'DESCRIPTOR' : _INVITEWAITINGROOMREQUEST,
  '__module__' : 'hiit_pb2'
  # @@protoc_insertion_point(class_scope:hiit.InviteWaitingRoomRequest)
  })
_sym_db.RegisterMessage(InviteWaitingRoomRequest)


DESCRIPTOR._options = None

_HIITSERVICE = _descriptor.ServiceDescriptor(
  name='HIITService',
  full_name='hiit.HIITService',
  file=DESCRIPTOR,
  index=0,
  serialized_options=None,
  create_key=_descriptor._internal_create_key,
  serialized_start=624,
  serialized_end=1000,
  methods=[
  _descriptor.MethodDescriptor(
    name='Sub',
    full_name='hiit.HIITService.Sub',
    index=0,
    containing_service=None,
    input_type=_ROUTINECHANGE,
    output_type=_DATA,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
  _descriptor.MethodDescriptor(
    name='Pub',
    full_name='hiit.HIITService.Pub',
    index=1,
    containing_service=None,
    input_type=_DATASESSION,
    output_type=_EMPTY,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
  _descriptor.MethodDescriptor(
    name='CreateWaitingRoom',
    full_name='hiit.HIITService.CreateWaitingRoom',
    index=2,
    containing_service=None,
    input_type=_CREATEWAITINGROOMREQUEST,
    output_type=_WAITINGROOMRESPONSE,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
  _descriptor.MethodDescriptor(
    name='JoinWaitingRoom',
    full_name='hiit.HIITService.JoinWaitingRoom',
    index=3,
    containing_service=None,
    input_type=_WAITINGROOMREQUEST,
    output_type=_WAITINGROOMRESPONSE,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
  _descriptor.MethodDescriptor(
    name='NotifyInvites',
    full_name='hiit.HIITService.NotifyInvites',
    index=4,
    containing_service=None,
    input_type=_INVITEWAITINGROOMREQUEST,
    output_type=_EMPTY,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
  _descriptor.MethodDescriptor(
    name='SubInvites',
    full_name='hiit.HIITService.SubInvites',
    index=5,
    containing_service=None,
    input_type=_HIITUSER,
    output_type=_INVITEWAITINGROOMREQUEST,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
])
_sym_db.RegisterServiceDescriptor(_HIITSERVICE)

DESCRIPTOR.services_by_name['HIITService'] = _HIITSERVICE

# @@protoc_insertion_point(module_scope)
