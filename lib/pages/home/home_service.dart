import 'package:dio/dio.dart';
import 'package:him_demo/library/api_request.dart';

class HomeService {
  static void uploadFile(String token, Map<String, dynamic> params,
      {Function(dynamic data)? onSuccess, Function(dynamic erorr)? onError}) {
    ApiRequest(
      url: 'https://sm.ms/api/v2/upload',
      data: params,
      headers: {'Authorization': token},
    ).upload(onSuccess: (data) {
      onSuccess!(data);
    }, onError: (error) {
      print(error);
    });
  }
}
