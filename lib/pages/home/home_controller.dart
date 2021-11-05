import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart' as MultipartFile;
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:him_demo/models/user_login_res.dart';
import 'package:him_demo/pages/alerts/alerts_service.dart';
import 'package:him_demo/pages/home/home_service.dart';
import 'package:him_demo/proto/WSBaseReqProto.pb.dart';
import 'package:him_demo/proto/WSBaseResProto.pb.dart';
import 'package:him_demo/proto/WSMessageResProto.pb.dart';
import 'package:him_demo/proto/WSUserResProto.pb.dart';
import 'package:him_demo/routes/app_routes.dart';
import 'package:him_demo/utils/websocket_manager.dart';
import 'package:image_picker/image_picker.dart';

enum msgType {
  // 消息类型（0：普通文字消息，1：图片消息，2：文件消息，3：语音消息，4：视频消息）
  txtMsg,
  picMsg,
  fileMsg,
  voiceMsg,
  videoMsg
}

class HomeController extends GetxController {
  late String username;
  late String password;
  late String targetName = '';
  late int targetId = -1;
  late int currentUid;
  late bool connectFlag = false;

  late ScrollController scrollController;

  List<WSBaseResProto> msgList = [];

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController sendController = TextEditingController();
  final store = GetStorage();

  // 如果没有登陆，则socket连接断开，如果登陆成功，则socket连接创建，并开始维持心跳活动
  bool loginFlag = false;

  startWebSocket() async {
    WebSocketManager.init();
    await WebSocketManager().connect();

    /// 准备登陆数据
    Uint8List loginParam = buildWSBaseReqProto(
        1, store.read("userInfo").sid, store.read("userInfo").uid);
    WebSocketManager().send(loginParam);

    /// 开始心跳连接
    Timer.periodic(Duration(seconds: 30), (timer) {
      Uint8List heartBeatParam = buildWSBaseReqProto(
          0, store.read("userInfo").sid, store.read("userInfo").uid);
      WebSocketManager().send(heartBeatParam);
    });
    WebSocketManager().channel.stream.listen((msg) {
      msgList.add(WSBaseResProto.fromBuffer(msg));
      update();
    });
  }

  @override
  void onClose() {
    WebSocketManager manager = WebSocketManager();
    manager.disconnect();
    manager.dispose();
    super.onClose();
  }

  void loginAction() {
    FormState? formState = formKey.currentState;
    if (formState!.validate()) {
      formState.save();
      AlertsService().login(
        username,
        password,
        onSuccess: (data) {
          store.write('userInfo', data);
          loginFlag = true;
          currentUid = data.uid;
          update();
          Get.toNamed(AppRoutes.FRIENDLIST);
        },
        onError: (error) {
          print(error.toString());
        },
      );
    }
  }

  Uint8List buildWSBaseReqProto(int type, String sid, int uid) {
    WSBaseReqProto wsBaseReqProto = WSBaseReqProto.create();
    if (type == 1) {
      wsBaseReqProto.sid = sid;
      wsBaseReqProto.uid = Int64(uid);
      wsBaseReqProto.type = 1;
    } else {
      wsBaseReqProto.type = 0;
    }
    return wsBaseReqProto.writeToBuffer();
  }

  void addFile() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    final String token = '2vE3ykFomT8qt0rmkGctu6Q9S83Oj7It';
    var file = await MultipartFile.MultipartFile.fromFile(image!.path,
        filename: image.name);
    HomeService.uploadFile(token, {'smfile': file}, onSuccess: (data) {
      var res = json.decode(data);
      String imgUrl = '';
      if (res['images'] != null) {
        imgUrl = res['images'];
      }
      if (res['images'] == null &&
          res['data']['url'] != null &&
          res['data']['url'] != '') {
        imgUrl = res['data']['url'];
      }
      // 开始发送图片消息到服务器
      WSBaseResProto params = createOwnMsg(imgUrl, msgType.picMsg);
      msgList.add(params);

      /// 开始发送ajax消息
      UserLoginRes userInfo = store.read('userInfo');
      AlertsService().sendMsg(imgUrl, targetId, msgType.picMsg.index,
          userInfo.uid.toString(), userInfo.sid);
      update();
    });
  }

  void sendMsg() {
    if (targetId == -1) {
      Get.snackbar('警告', '请先选择聊天对象！侧滑可以看到聊天列表！');
      return;
    }
    var res = sendController.text;
    if (res == '') {
      Get.snackbar('警告', '请输入消息，消息不能为空！');
      return;
    }

    /// 整理自己发出的消息到列表中去
    msgList.add(createOwnMsg(res, msgType.txtMsg));

    /// 开始发送ajax消息
    UserLoginRes userInfo = store.read('userInfo');
    AlertsService()
        .sendMsg(res, targetId, msgType.txtMsg.index, userInfo.uid.toString(), userInfo.sid);
    sendController.clear();
    update();
  }

  WSBaseResProto createOwnMsg(String msg, msgType msgType) {
    WSBaseResProto wsBaseResProto = WSBaseResProto.create();
    wsBaseResProto.createTime = DateTime.now().toString();
    WSMessageResProto messageResProto = WSMessageResProto.create();
    messageResProto.msgContent = msg;

    messageResProto.msgType = msgType.index;
    messageResProto.receiveId = Int64(targetId);
    wsBaseResProto.message = messageResProto;
    WSUserResProto wsUserResProto = WSUserResProto.create();
    wsUserResProto.avatar = store.read('userInfo').avatar;
    wsUserResProto.name = store.read('userInfo').name;
    wsUserResProto.uid = Int64(store.read('userInfo').uid);
    wsBaseResProto.user = wsUserResProto;
    return wsBaseResProto;
  }
}
