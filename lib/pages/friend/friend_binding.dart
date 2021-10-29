import 'package:get/get.dart';
import 'package:him_demo/pages/friend/friend_controller.dart';

class FriendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FriendController>(() => FriendController());
  }
}
