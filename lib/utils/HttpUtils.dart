import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/widget/Loadding.dart';

class BaseUrl {
  // 配置默认请求地址
  static const String url = 'http://10.0.0.153:7788';
}

class HttpUtils {
  static Dio _dio;

  factory HttpUtils() => init();

  static HttpUtils _instance;

  HttpUtils._internal() {
    // 初始化
    _dio = Dio(new BaseOptions(
      baseUrl: BaseUrl.url,
      connectTimeout: 5000,
      receiveTimeout: 100000,
      // 5s
      contentType: ContentType.json,
      responseType: ResponseType.json,
    ));
    _dio.interceptors.add(LogInterceptor(responseBody: true)); //开启请求日志
  }

  // 获取对象
  static HttpUtils init() {
    if (_instance == null) {
      // 使用私有的构造方法来创建对象
      _instance = new HttpUtils._internal();
    }
    return _instance;
  }

  static HttpUtils getInstance() => init();


  ///回调的方式
  void getCallback(String url,
      {Map<String, dynamic> data,
      Map<String, dynamic> headers,
      Function success,
      Function error,
      BuildContext context,
      String loadTitle}) async {
    // 发送get请求
    await _sendRequestCallback(url, 'get', success,
        headers: headers, error: error, data: data,context: context,loadTitle: loadTitle);
  }

 ///回调的方式
  void postCallback(String url,
      {Map<String, dynamic> data,
      Map<String, dynamic> headers,
      Function success,
      Function error,
      BuildContext context,
      String loadTitle}) async {
    // 发送post请求
    _sendRequestCallback(url, 'post', success,
        data: data, headers: headers, error: error,context: context,loadTitle: loadTitle);
  }




  // 请求处理
  static Future _sendRequestCallback(String url, String method, Function success,
      {Map<String, dynamic> data,
      Map<String, dynamic> headers,
      Function error,
      BuildContext context,
      String loadTitle }) async {
    int _code;
    String _msg;
    var _backData;
    if (context != null) {

      Loadding.showLoad(context, loadTitle);
    }
    try {
      Map<String, dynamic> dataMap = data == null ? new Map() : data;
      Map<String, dynamic> headersMap = headers == null ? new Map() : headers;

      // 配置dio请求信息
      Response response;

      _dio.options.headers
          .addAll(headersMap); // 添加headers,如需设置统一的headers信息也可在此添加

      if (method == 'get') {
        response = await _dio.get(url, queryParameters: dataMap);
      } else if (method == "post") {
        response = await _dio.post(url, data: dataMap);
      }

      if (response.statusCode != 200) {
        _msg = '网络请求错误,状态码:' + response.statusCode.toString();
        _handError(error, _msg);
        if (context != null) {
          Navigator.pop(context);
        }
        return;
      }

      // 返回结果处理

      Map<String, dynamic> resCallbackMap = response.data;


      _code = resCallbackMap['code'];
      _msg = resCallbackMap['msg'];
      _backData = resCallbackMap['data'];


      if (success != null) {
        if (context != null) {
          Navigator.pop(context);
        }
        if (_code == 200) {
          success(response.data);
        } else {
          String errorMsg = _code.toString() + ':' + _msg;
          _handError(error, errorMsg);
        }

      }
    } catch (exception) {
      _handError(error, '数据请求错误：' + exception.toString());
      if (context != null) {
        Navigator.pop(context);
      }
    }
  }

  // 返回错误信息
  static Future _handError(Function errorCallback, String errorMsg) {
    if (errorCallback != null) {
      errorCallback(errorMsg);
    }
  }








  /*********************Future 方式********************************/

  Future< Map<String, dynamic>> get(String url,
      {Map<String, dynamic> data,
        Map<String, dynamic> headers,
        BuildContext context,
        String loadTitle}) async{
   return  _sendRequest(url,"get",data: data,headers: headers,context: context,loadTitle:loadTitle );
  }
  ///回调的方式

  Future< Map<String, dynamic>> post(String url,
      {Map<String, dynamic> data,
        Map<String, dynamic> headers,

        BuildContext context,
        String loadTitle}) async {
    // 发送post请求
    return _sendRequest(url, 'post',
        data: data, headers: headers,context: context,loadTitle: loadTitle);
  }
  // 请求处理
  static  Future< Map<String, dynamic>> _sendRequest(String url,String method,
      {Map<String, dynamic> data,
        Map<String, dynamic> headers,
        Function error,
        BuildContext context,
        String loadTitle }) async {

    if (context != null) {
      Loadding.showLoad(context, loadTitle);
    }
    try {
      Map<String, dynamic> dataMap = data == null ? new Map() : data;
      Map<String, dynamic> headersMap = headers == null ? new Map() : headers;

      // 配置dio请求信息
      Response response;

      _dio.options.headers
          .addAll(headersMap); // 添加headers,如需设置统一的headers信息也可在此添加

      if (method == 'get') {
        response = await _dio.get(url, queryParameters: dataMap);
      } else if (method == "post") {
        response = await _dio.post(url, data: dataMap);
      }
      if (context != null) {
        Navigator.pop(context);
      }
      return response.data;
    }catch(exception){
      if (context != null) {
        Navigator.pop(context);
      }
      return Future.value({"code":-1,"msg":'数据请求错误：' + exception.toString()});
    }
  }
}
