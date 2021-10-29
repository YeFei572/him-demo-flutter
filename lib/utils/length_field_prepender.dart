import 'dart:convert';
import 'dart:typed_data';

import 'package:him_demo/proto/WSBaseReqProto.pb.dart';
import 'package:him_demo/proto/WSBaseResProto.pb.dart';

class LengthFieldPrepender {
  final int lengthFieldLength;

  LengthFieldPrepender(this.lengthFieldLength) {
    if (lengthFieldLength != 1 &&
        lengthFieldLength != 2 &&
        lengthFieldLength != 4 &&
        lengthFieldLength != 8) {
      throw ArgumentError("协议头长度必须是1、2、4、8，当前长度为：$lengthFieldLength");
    }
  }

  List<int> encode(WSBaseReqProto wsBaseReqProto) {
    Uint8List msgBuffer = wsBaseReqProto.writeToBuffer();
    int length = msgBuffer.length;
    switch (this.lengthFieldLength) {
      case 1:
        if (length >= 256) {
          throw ArgumentError("length does not fit into a byte: $length");
        }
        var header = ByteData(1);
        header.setInt8(0, length);
        return header.buffer.asUint8List() + msgBuffer;
      case 2:
        if (length >= 65536) {
          throw ArgumentError(
              "length does not fit into a short integer: $length");
        }
        var header = ByteData(2);
        header.setInt16(0, length);
        return header.buffer.asUint8List() + msgBuffer;
      case 4:
        var header = ByteData(4);
        header.setInt32(0, length);
        return header.buffer.asUint8List() + msgBuffer;
      case 8:
        var header = ByteData(8);
        header.setInt64(0, length);
        return header.buffer.asUint8List() + msgBuffer;
      case 3:
      case 5:
      case 6:
      case 7:
      default:
        throw FormatException("should not reach here");
    }
  }

  WSBaseResProto decode(Uint8List msg) {
    print('-------msgBuffer.length = ${msg.length} ');
    if (msg.length < 200) {
      return WSBaseResProto.fromBuffer(msg.sublist(1, msg.length));
    }
    if (msg.length < 65536) {
      return WSBaseResProto.fromBuffer(msg.sublist(2, msg.length));
    } else {
      return WSBaseResProto.fromBuffer(msg.sublist(4, msg.length));
    }
  }


}
