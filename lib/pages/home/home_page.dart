import 'package:cached_network_image/cached_network_image.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:him_demo/pages/home/home_controller.dart';
import 'package:him_demo/proto/WSBaseResProto.pb.dart';
import 'package:him_demo/routes/app_routes.dart';

class HomePage extends GetView<HomeController> {
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          body: controller.loginFlag
              ? buildDialogWidget(controller, context)
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

  Widget buildLoginWidget(HomeController controller) {
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

  Widget buildDialogWidget(HomeController controller, BuildContext ctx) {
    return Container(
      child: RefreshIndicator(
        onRefresh: () async {},
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
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                height: 70.w,
                // 构建发送消息界面
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: onBuildSendGroup(ctx)),
                      InkWell(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Icon(Icons.send,
                                size: 40.sp, color: Color(0xff989696)),
                          ),
                          onTap: controller.sendMsg),
                      InkWell(
                          onTap: controller.addFile,
                          child: Icon(Icons.add,
                              size: 40.sp, color: Color(0xff989696))),
                    ]))
          ],
        ),
      ),
    );
  }

  Widget onBuildSendGroup(BuildContext ctx) {
    return TextField(
      controller: controller.sendController,
      maxLines: 2,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10.w),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0x00FF0000)),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffe0e0e0)),
          borderRadius: BorderRadius.all(Radius.circular(5)),
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
        child: item.message.msgType == msgType.txtMsg.index
            ? Text(item.message.msgContent)
            : CachedNetworkImage(
                imageUrl: item.message.msgContent, width: 200.w, height: 200.w),
      ),
    );
  }
}
