

import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';

class BaseUrl {
  // 配置默认请求地址
  static const String url = 'http://10.0.0.142:3000';
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

  // 用户对象

  void get(String url,
      {Map<String, dynamic> data,
      Map<String, dynamic> headers,
      Function success,
      Function error}) async {


    // 发送get请求
    await _sendRequest(url, 'get', success, headers: headers, error: error,data: data);
  }

  void post(String url,
      {Map<String, dynamic> data,
      Map<String, dynamic> headers,
      Function success,
      Function error}) async {
    // 发送post请求
    _sendRequest(url, 'post', success,
        data: data, headers: headers, error: error);
  }

  // 请求处理
  static Future _sendRequest(String url, String method, Function success,
      {Map<String, dynamic> data,
      Map<String, dynamic> headers,
      Function error}) async {
    int _code;
    String _msg;
    var _backData;

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
        return;
      }

      // 返回结果处理


      Map<String, dynamic> resCallbackMap = response.data;


      _code = resCallbackMap['code'];
      _msg = resCallbackMap['msg'];
      _backData = resCallbackMap['data'];

      if (success != null) {
        if (_code == 0) {
          success(_backData);
        } else {
          String errorMsg = _code.toString() + ':' + _msg;
          _handError(error, errorMsg);
        }
      }
    } catch (exception) {
      _handError(error, '数据请求错误：' + exception.toString());
    }
  }

  // 返回错误信息
  static Future _handError(Function errorCallback, String errorMsg) {
    if (errorCallback != null) {
      errorCallback(errorMsg);
    }
  }
}
