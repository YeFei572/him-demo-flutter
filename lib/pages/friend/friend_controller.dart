import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:him_demo/models/user_friend_item.dart';
import 'package:him_demo/models/user_login_res.dart';
import 'package:him_demo/pages/friend/friend_service.dart';

class FriendController extends GetxController {
  final store = GetStorage();

  List<UserFriendItem> userFriends = [];

  @override
  void onInit() {
    UserLoginRes res = store.read('userInfo');
    this.getMyFriends(res.sid, res.uid);
    super.onInit();
  }

  void getMyFriends(String sid, int uid) {
    FriendService.getMyFriends(
      sid,
      uid,
      onSuccess: (items) {
        userFriends = items;
        print('朋友列表长度： ${userFriends.length}');
        update();
      },
    );
  }

  toChat(int friendUid, String sid) {
    print('$friendUid,   $sid');
  }
}
