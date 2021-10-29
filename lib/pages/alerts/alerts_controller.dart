import 'dart:async';
import 'dart:io';

import 'package:fixnum/fixnum.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:him_demo/models/user_login_res.dart';
import 'package:him_demo/proto/WSBaseReqProto.pb.dart';
import 'package:him_demo/proto/WSBaseResProto.pbserver.dart';
import 'package:him_demo/proto/WSMessageResProto.pb.dart';
import 'package:him_demo/proto/WSUserResProto.pb.dart';
import 'package:him_demo/routes/app_routes.dart';
import 'package:him_demo/utils/encodec_utils.dart';
import 'package:him_demo/utils/length_field_prepender.dart';

import 'alerts_service.dart';

class AlertsController extends GetxController {
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

  @override
  void onInit() {
    super.onInit();
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

  Future refreshPage() async {}

  void startConnection() async {
    /// 判断当前是否已经登陆并连接， 如果已经登陆并链接就不做处理，如果没有则往下执行。
    if (connectFlag) {
      return;
    }
    UserLoginRes info = store.read('userInfo');
    await Socket.connect('172.16.0.193', 9002).then((socket) {
      connectFlag = true;
      update();

      /// 创建连接鉴权
      socket.add(buildWSBaseReqProto(1, info.sid, info.uid));

      /// 开始维持心跳, 每30s进行一次心跳连接
      Timer.periodic(Duration(seconds: 30), (timer) {
        socket.add(buildWSBaseReqProto(0, info.sid, info.uid));
      });

      /// 开始监听socket记录
      socket.listen((event) {
        LengthFieldPrepender lengthFieldPrepender = LengthFieldPrepender(1);
        WSBaseResProto res = lengthFieldPrepender.decode(event);

        msgList.add(res);
        update();
      });
    });
  }

  List<int> buildWSBaseReqProto(int type, String sid, int uid) {
    WSBaseReqProto wsBaseReqProto = WSBaseReqProto.create();
    if (type == 1) {
      wsBaseReqProto.sid = sid;
      wsBaseReqProto.uid = Int64(uid);
      wsBaseReqProto.type = 1;
    } else {
      wsBaseReqProto.type = 0;
    }
    return getProtocBufferData(wsBaseReqProto.writeToBuffer());
  }

  void sendMsg() {
    if (targetId == -1) {
      Get.snackbar('警告', '请先选择聊天对象！侧滑可以看到聊天列表！');
      return;
    }
    var res = sendController.text;

    /// 整理自己发出的消息到列表中去
    msgList.add(createOwnMsg(res));

    /// 开始发送ajax消息
    UserLoginRes userInfo = store.read('userInfo');
    AlertsService()
        .sendMsg(res, targetId, 0, userInfo.uid.toString(), userInfo.sid);
    sendController.clear();
    update();
  }

  WSBaseResProto createOwnMsg(String msg) {
    WSBaseResProto wsBaseResProto = WSBaseResProto.create();
    wsBaseResProto.createTime = DateTime.now().toString();
    WSMessageResProto messageResProto = WSMessageResProto.create();
    messageResProto.msgContent = msg;
    // 消息类型（0：普通文字消息，1：图片消息，2：文件消息，3：语音消息，4：视频消息）
    messageResProto.msgType = 0;
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
