import 'package:him_demo/library/api_request.dart';
import 'package:him_demo/models/user_friend_item.dart';

class FriendService {
  static void getMyFriends(
    String sid,
    int uid, {
    Function(List<UserFriendItem> items)? onSuccess,
    Function(dynamic erorr)? onError,
  }) {
    ApiRequest(
      url: 'http://172.16.0.193:9000/api/user/friend/lists',
      data: {'page': 1, 'limit': 100},
      headers: {'uid': uid.toString(), 'sid': sid},
    ).get(onSuccess: (data) {
      onSuccess!((data['data'] as List)
          .map((item) => UserFriendItem.fromJson(item))
          .toList());
    }, onError: (error) {
      print(error);
    });
  }
}
