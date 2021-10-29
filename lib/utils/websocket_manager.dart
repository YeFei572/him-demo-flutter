import 'dart:async';
import 'dart:typed_data';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

enum StatusEnum { connect, connecting, close, closing }

class WebSocketManager {
  static late WebSocketManager _singleton;

  factory WebSocketManager() {
    return _singleton;
  }

  late WebSocketChannel channel;

  StreamController<StatusEnum> socketStatusController =
      StreamController<StatusEnum>();

  WebSocketManager._();

  static void init() async {
    _singleton = WebSocketManager._();
  }

  StatusEnum isConnect = StatusEnum.close; // 默认为关闭连接
  String _url = "ws://172.16.0.193:9001/ws";

  Future connect() async {
    if(isConnect == StatusEnum.close) {
      isConnect = StatusEnum.connecting;
      socketStatusController.add(StatusEnum.connecting);
      channel = IOWebSocketChannel.connect(Uri.parse(_url));
      isConnect = StatusEnum.connect;
      socketStatusController.add(StatusEnum.connect);
      return channel;
    }
  }

  Future disconnect() async {
    if(isConnect == StatusEnum.connect) {
      isConnect = StatusEnum.closing;
      socketStatusController.add(StatusEnum.closing);
      await channel.sink.close(3000, '主动关闭');
      isConnect = StatusEnum.close;
      socketStatusController.add(StatusEnum.close);
    }
  }

  bool send(Uint8List msg) {
    if (isConnect == StatusEnum.connect) {
      channel.sink.add(msg);
      return true;
    }
    return false;
  }

  void dispose() {
    socketStatusController.close();
  }
}
