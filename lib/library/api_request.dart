import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiRequest {
  late final String url;
  late final Map<String, dynamic> data;
  late final Map<String, dynamic> headers;

  ApiRequest({required this.url, required this.data, required this.headers});

  Dio _dio() {
    return Dio(BaseOptions(headers: this.headers));
  }

  void get(
      {Function()? beforeSend,
      Function(dynamic data)? onSuccess,
      Function(dynamic error)? onError}) {
    print("请求地址：==========>${this.url}");
    _dio()
        .get(this.url, queryParameters: this.data)
        .then((value) => {
              print("请求结果：==========>$value}"),
              if (onSuccess != null) {onSuccess(value.data)}
            })
        .catchError((error) => {
              if (onError != null) {onError(error)}
            });
  }

  void post({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    print("请求地址：==========>${this.url}");
    _dio()
        .post(this.url, data: this.data)
        .then((value) => {
              print("请求结果：==========>$value}"),
              if (onSuccess != null) {onSuccess(value.data)}
            })
        .catchError((error) => {
              if (onError != null) {onError(error)}
            });
  }
}
