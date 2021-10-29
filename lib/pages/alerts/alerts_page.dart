import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:him_demo/proto/WSBaseResProto.pb.dart';
import 'package:him_demo/routes/app_routes.dart';

import 'alerts_controller.dart';

class AlertsPage extends GetView<AlertsController> {
  Widget build(BuildContext context) {
    return GetBuilder<AlertsController>(
      builder: (controller) {
        return Scaffold(
          body: controller.loginFlag
              ? buildDialogWidget(controller)
              : buildLoginWidget(controller),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: Icon(Icons.people_alt_rounded),
                onPressed: () => Get.toNamed(AppRoutes.FRIENDLIST),
              )
            ],
            centerTitle: true,
            title: controller.loginFlag
                ? Text(controller.targetName,
                    style: TextStyle(color: Colors.white))
                : Text('登陆', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.green,
          ),
        );
      },
    );
  }

  Widget buildLoginWidget(AlertsController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 50.w),
                  child: TextFormField(
                    initialValue: '6',
                    onSaved: (val) {
                      controller.username = val!;
                    },
                    decoration: InputDecoration(
                      labelText: '用户名',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.w)),
                    ),
                  ),
                ),
                TextFormField(
                  initialValue: '123',
                  onSaved: (val) {
                    controller.password = val!;
                  },
                  validator: (val) {
                    return val!.length < 3 ? '密码长度不对' : null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: '密码',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.w)),
                  ),
                ),
              ],
            ),
          ),
        ),
        ElevatedButton(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              '请登陆',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 27.sp),
            ),
            width: 200.w,
            height: 80.w,
          ),
          onPressed: controller.loginAction,
        ),
      ],
    );
  }

  Widget buildDialogWidget(AlertsController controller) {
    return Container(
      child: RefreshIndicator(
        onRefresh: controller.refreshPage,
        child: Column(
          children: [
            Flexible(
              child: GestureDetector(
                onTap: () {},
                child: ListView.builder(
                  itemCount: controller.msgList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildMsgItem(context, index);
                  },
                ),
              ),
            ),
            Divider(height: 2.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              height: 60.w,
              // 构建发送消息界面
              child: onBuildSendGroup(),
            )
          ],
        ),
      ),
    );
  }

  Widget onBuildSendGroup() {
    return TextField(
      controller: controller.sendController,
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          child: Icon(Icons.send),
          onTap: controller.sendMsg,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0x00FF0000)),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0x00000000)),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }

  Widget buildMsgItem(BuildContext context, int index) {
    WSBaseResProto item = controller.msgList[index];
    bool msgFromOthers = Int64(controller.currentUid) == item.message.receiveId;
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        mainAxisAlignment:
            msgFromOthers ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: msgFromOthers
            ? [buildAvatar(item), buildMsgContent(item, msgFromOthers)]
            : [buildMsgContent(item, msgFromOthers), buildAvatar(item)],
      ),
    );
  }

  Widget buildAvatar(WSBaseResProto item) {
    return CircleAvatar(
      radius: 30.w,
      backgroundImage: NetworkImage(item.user.avatar),
    );
  }

  Widget buildMsgContent(WSBaseResProto item, bool msgFromOthers) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 450.w),
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(10.w),
            boxShadow: [
              BoxShadow(
                  color: msgFromOthers ? Colors.black12 : Color(0xff9eea6a))
            ]),
        margin: msgFromOthers
            ? EdgeInsets.only(left: 20.w)
            : EdgeInsets.only(right: 20.w),
        child: Text(item.message.msgContent),
      ),
    );
  }
}
