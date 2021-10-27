///
//  Generated code. Do not modify.
//  source: WSBaseResProto.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'WSMessageResProto.pb.dart' as $0;
import 'WSUserResProto.pb.dart' as $1;

class WSBaseResProto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WSBaseResProto', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'protocol'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.O3)
    ..aOM<$0.WSMessageResProto>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message', subBuilder: $0.WSMessageResProto.create)
    ..aOM<$1.WSUserResProto>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'user', subBuilder: $1.WSUserResProto.create)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createTime')
    ..hasRequiredFields = false
  ;

  WSBaseResProto._() : super();
  factory WSBaseResProto({
    $core.int? type,
    $0.WSMessageResProto? message,
    $1.WSUserResProto? user,
    $core.String? createTime,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (message != null) {
      _result.message = message;
    }
    if (user != null) {
      _result.user = user;
    }
    if (createTime != null) {
      _result.createTime = createTime;
    }
    return _result;
  }
  factory WSBaseResProto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WSBaseResProto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WSBaseResProto clone() => WSBaseResProto()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WSBaseResProto copyWith(void Function(WSBaseResProto) updates) => super.copyWith((message) => updates(message as WSBaseResProto)) as WSBaseResProto; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WSBaseResProto create() => WSBaseResProto._();
  WSBaseResProto createEmptyInstance() => create();
  static $pb.PbList<WSBaseResProto> createRepeated() => $pb.PbList<WSBaseResProto>();
  @$core.pragma('dart2js:noInline')
  static WSBaseResProto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WSBaseResProto>(create);
  static WSBaseResProto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get type => $_getIZ(0);
  @$pb.TagNumber(1)
  set type($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $0.WSMessageResProto get message => $_getN(1);
  @$pb.TagNumber(2)
  set message($0.WSMessageResProto v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
  @$pb.TagNumber(2)
  $0.WSMessageResProto ensureMessage() => $_ensure(1);

  @$pb.TagNumber(3)
  $1.WSUserResProto get user => $_getN(2);
  @$pb.TagNumber(3)
  set user($1.WSUserResProto v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasUser() => $_has(2);
  @$pb.TagNumber(3)
  void clearUser() => clearField(3);
  @$pb.TagNumber(3)
  $1.WSUserResProto ensureUser() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get createTime => $_getSZ(3);
  @$pb.TagNumber(4)
  set createTime($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCreateTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreateTime() => clearField(4);
}

