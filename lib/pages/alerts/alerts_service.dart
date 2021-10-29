import 'package:get/get.dart';
import 'package:him_demo/library/api_request.dart';
import 'package:him_demo/models/user_login_res.dart';

class AlertsService {
  void login(String? username, String? password,
      {Function(UserLoginRes data)? onSuccess,
      Function(dynamic erorr)? onError}) {
    ApiRequest(
      url: 'http://172.16.0.193:9000/api/user/login/byPwd',
      data: {'uid': username, 'pwd': password},
      headers: {},
    ).post(
      onSuccess: (data) {
        if (data['code'] == 0) {
          onSuccess!(UserLoginRes.fromJson(data['data']));
        } else if (data['code'] == 2) {
          Get.snackbar("警告", data['message']);
          return null;
        }
      },
      onError: (error) {
        print(error);
        return error;
      },
    );
  }

  void sendMsg(
      String msg, int receiverUid, int msgType, String currentUid, String sid) {
    ApiRequest(
      url: 'http://172.16.0.193:9000/api/user/friendMsg/create',
      data: {'receiverUid': receiverUid, 'msgType': msgType, 'msgContent': msg},
      headers: {'uid': currentUid, 'sid': sid},
    ).post(
        onSuccess: (data) {},
        onError: (error) {
          print(error);
        });
  }
}
