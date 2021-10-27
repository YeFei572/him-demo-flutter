///
//  Generated code. Do not modify.
//  source: WSMessageResProto.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class WSMessageResProto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WSMessageResProto', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'protocol'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiveId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msgType', $pb.PbFieldType.O3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msgContent')
    ..hasRequiredFields = false
  ;

  WSMessageResProto._() : super();
  factory WSMessageResProto({
    $fixnum.Int64? receiveId,
    $core.int? msgType,
    $core.String? msgContent,
  }) {
    final _result = create();
    if (receiveId != null) {
      _result.receiveId = receiveId;
    }
    if (msgType != null) {
      _result.msgType = msgType;
    }
    if (msgContent != null) {
      _result.msgContent = msgContent;
    }
    return _result;
  }
  factory WSMessageResProto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WSMessageResProto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WSMessageResProto clone() => WSMessageResProto()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WSMessageResProto copyWith(void Function(WSMessageResProto) updates) => super.copyWith((message) => updates(message as WSMessageResProto)) as WSMessageResProto; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WSMessageResProto create() => WSMessageResProto._();
  WSMessageResProto createEmptyInstance() => create();
  static $pb.PbList<WSMessageResProto> createRepeated() => $pb.PbList<WSMessageResProto>();
  @$core.pragma('dart2js:noInline')
  static WSMessageResProto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WSMessageResProto>(create);
  static WSMessageResProto? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get receiveId => $_getI64(0);
  @$pb.TagNumber(1)
  set receiveId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasReceiveId() => $_has(0);
  @$pb.TagNumber(1)
  void clearReceiveId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get msgType => $_getIZ(1);
  @$pb.TagNumber(2)
  set msgType($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsgType() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsgType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get msgContent => $_getSZ(2);
  @$pb.TagNumber(3)
  set msgContent($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMsgContent() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsgContent() => clearField(3);
}

