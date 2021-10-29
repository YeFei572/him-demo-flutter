import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:him_demo/models/user_friend_item.dart';
import 'package:him_demo/pages/alerts/alerts_controller.dart';

import 'friend_controller.dart';

class FriendPage extends GetView<FriendController> {
  @override
  Widget build(BuildContext context) {
    AlertsController aController = Get.find();
    return GetBuilder<FriendController>(
      builder: (controller) => Scaffold(
        body: Container(
          padding: EdgeInsets.all(20.w),
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemCount: controller.userFriends.length,
            itemBuilder: (BuildContext context, int index) {
              UserFriendItem item = controller.userFriends[index];
              return GestureDetector(
                onTap: () {
                  aController.targetId = item.friendUid;
                  aController.targetName = item.user.name;
                  aController.msgList.clear();
                  aController.startConnection();
                  aController.update();
                  Get.back();
                },
                child: Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                      color: Colors.pink[50],
                      borderRadius: BorderRadius.circular(10.w)),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40.w,
                        backgroundImage: NetworkImage(item.user.avatar),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 14.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.user.name),
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 580.w),
                              child: Text(
                                item.user.remark,
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
