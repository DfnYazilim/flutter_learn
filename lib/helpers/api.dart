// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/helpers/token.dart';


class Api {
  String baseUrl = "http://172.20.10.2:6032/api/";
  var dio = Dio();
  String? token;
  setHeaderWithOutToken() {
    Map<String, String> q = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'mobileHeader': 'nAvn4gsYD=;2:.4"'
    };
    return q;
  }

  setHeaderWithToken() async {
    final tkn = await Token.readToken('login');
    if (tkn != null) {
      token = tkn;
    }
    Map<String, String> q = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ' + (token ?? ''),
      'mobileHeader': 'nAvn4gsYD=;2:.4"'
    };
    return q;
  }

  Future<Response?> dioPost(
      {required String url,
      String? fullUrl,
      bool useToken = true,
      Map<String, dynamic>? obj,
      bool post = true}) async {
    Map<String, String> headers;
    if (useToken) {
      headers = await setHeaderWithToken();
    } else {
      headers = setHeaderWithOutToken();
    }
    try {
      Response response;
      if (post) {
        response = await dio.post(fullUrl ?? baseUrl + url,
            data: obj,
            options: Options(
              headers: headers,
            ));
        print(response);
      } else {
        response = await dio.put(baseUrl + url,
            data: obj,
            options: Options(
              headers: headers,
            ));
      }
      print(response.data);
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response?> dioGet(
 {
    required String url,
    bool useToken = true,
    bool get = true,
        Map<String, dynamic>? obj,
  }) async {
    Map<String, String> headers;
    if (useToken) {
      headers = await setHeaderWithToken();
    } else {
      headers = setHeaderWithOutToken();
    }
    try {
      Response response;
      if (get) {
        response =
            await dio.get(baseUrl + url, options: Options(headers: headers));
      } else {
        response = await dio.delete(baseUrl + url,
            options: Options(headers: headers), data: obj);
      }
      return response;
    } on DioError catch (e) {
      print('dioPost error : $e');
      return e.response;
    }
  }

  Future<Response?> dioPostMultiPart(
      {required String url,
      required FormData obj,
      bool useToken = true}) async {
    Map<String, String> headers;
    if (useToken) {
      headers = await setHeaderWithToken();
    } else {
      headers = setHeaderWithOutToken();
    }
    try {
      Response response = await Dio()
          .post(baseUrl + url, data: obj, options: Options(headers: headers));
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }


}
