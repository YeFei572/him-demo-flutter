import 'package:him_demo/library/api_request.dart';
import 'package:him_demo/models/post.dart';

class PostsService {
  void getPostsList({
    Function()? beforeSend,
    Function(List<Post> posts)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    ApiRequest(
        url: "https://jsonplaceholder.typicode.com/posts",
        data: {},
        headers: {}).get(
      beforeSend: () => {
        if (null != beforeSend) {},
      },
      onSuccess: (data) => {
        onSuccess!(
          (data as List).map((postJson) => Post.fromJson(postJson)).toList(),
        ),
      },
      onError: (error) => {
        if (null != error) {onError!(error)}
      },
    );
  }
}
