import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:him_demo/pages/components/loading_overlay.dart';

import 'posts_controller.dart';

class PostsPage extends GetView<PostsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('帖子页面'),
      ),
      body: Container(
        child: GetBuilder<PostsController>(
          builder: (controller) {
            return LoadingOverlay(
                isLoading: controller.isLoading,
                child: ListView.separated(
                  itemCount: controller.postsList.length,
                  itemBuilder: (context, index) {
                    return Container(
                        child: ListTile(
                            title: Text(controller.postsList[index].title),
                            subtitle: Text(controller.postsList[index].body)));
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                ));
          },
        ),
      ),
    );
  }
}
