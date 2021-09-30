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
  serialized_options=None,
  create_key=_descriptor._internal_create_key,
  serialized_pb=b'\n\nhiit.proto\x12\x04hiit\"\x07\n\x05\x45mpty\"\x17\n\x07Session\x12\x0c\n\x04name\x18\x04 \x01(\t23\n\x0bHIITService\x12$\n\x04Join\x12\r.hiit.Session\x1a\x0b.hiit.Empty0\x01\x62\x06proto3'
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


_SESSION = _descriptor.Descriptor(
  name='Session',
  full_name='hiit.Session',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='name', full_name='hiit.Session.name', index=0,
      number=4, type=9, cpp_type=9, label=1,
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
  serialized_end=52,
)

DESCRIPTOR.message_types_by_name['Empty'] = _EMPTY
DESCRIPTOR.message_types_by_name['Session'] = _SESSION
_sym_db.RegisterFileDescriptor(DESCRIPTOR)

Empty = _reflection.GeneratedProtocolMessageType('Empty', (_message.Message,), {
  'DESCRIPTOR' : _EMPTY,
  '__module__' : 'hiit_pb2'
  # @@protoc_insertion_point(class_scope:hiit.Empty)
  })
_sym_db.RegisterMessage(Empty)

Session = _reflection.GeneratedProtocolMessageType('Session', (_message.Message,), {
  'DESCRIPTOR' : _SESSION,
  '__module__' : 'hiit_pb2'
  # @@protoc_insertion_point(class_scope:hiit.Session)
  })
_sym_db.RegisterMessage(Session)



_HIITSERVICE = _descriptor.ServiceDescriptor(
  name='HIITService',
  full_name='hiit.HIITService',
  file=DESCRIPTOR,
  index=0,
  serialized_options=None,
  create_key=_descriptor._internal_create_key,
  serialized_start=54,
  serialized_end=105,
  methods=[
  _descriptor.MethodDescriptor(
    name='Join',
    full_name='hiit.HIITService.Join',
    index=0,
    containing_service=None,
    input_type=_SESSION,
    output_type=_EMPTY,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
])
_sym_db.RegisterServiceDescriptor(_HIITSERVICE)

DESCRIPTOR.services_by_name['HIITService'] = _HIITSERVICE

# @@protoc_insertion_point(module_scope)