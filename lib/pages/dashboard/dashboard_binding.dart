import 'package:get/get.dart';
import 'package:him_demo/pages/account/account_controller.dart';
import 'package:him_demo/pages/alerts/alerts_controller.dart';
import 'package:him_demo/pages/home/home_controller.dart';
import 'package:him_demo/pages/posts/posts_controller.dart';

import 'dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<PostsController>(() => PostsController());
    Get.lazyPut<AlertsController>(() => AlertsController());
    Get.lazyPut<AccountController>(() => AccountController());
  }
}
