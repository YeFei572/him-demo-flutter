import 'package:get/get.dart';
import 'package:him_demo/models/post.dart';

import 'posts_service.dart';

class PostsController extends GetxController {
  List<Post> postsList = [];
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    // PostsService().getPostsList(
    //   onSuccess: (posts) {
    //     print('==========> ${posts.length}');
    //     posts.map((e) => print(e.title));
    //     postsList.addAll(posts);
    //     isLoading = false;
    //     update();
    //   },
    //   onError: (error) {
    //     isLoading = false;
    //     update();
    //   },
    // );
  }
}
