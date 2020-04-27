import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

//请求
class FlappyRequest {
  //创建channel
  static const MethodChannel _channel =
      const MethodChannel('flutterflappyrequest');

  //请求URL
  String url;

  //超时时间
  int timeout = 30;

  //请求数据
  Map<String, dynamic> body;

  //请求header
  Map<String, dynamic> header;

  //构造器
  FlappyRequest({this.body, this.header, this.url, this.timeout});

  //转换
  FlappyRequest.fromJson(Map<String, dynamic> json) {
    body = json['body'];
    header = json['header'];
    url = json['url'];
    timeout = json['timeout'];
  }

  //转换为json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['body'] = this.body;
    data['header'] = this.header;
    data['url'] = this.url;
    data['timeout'] = this.timeout;
    return data;
  }

  //发送param请求
  Future<String> postParam() async {
    final String retStr = await _channel.invokeMethod('postParam', {
      "url": url,
      "body": body == null ? "{}" : jsonEncode(body),
      "header": header == null ? "{}" : jsonEncode(header),
      "timeout": timeout == null ? "30" : timeout
    });
    return retStr;
  }

  //发送json请求
  Future<String> postJson() async {
    final String retStr = await _channel.invokeMethod('postJson', {
      "url": url,
      "body": body == null ? "{}" : jsonEncode(body),
      "header": header == null ? "{}" : jsonEncode(header),
      "timeout": timeout == null ? "30" : timeout
    });
    return retStr;
  }

  //获取get请求数据
  Future<String> get() async {
    final String retStr = await _channel.invokeMethod('get', {
      "url": url,
      "body": body == null ? "{}" : jsonEncode(body),
      "header": header == null ? "{}" : jsonEncode(header),
      "timeout": timeout == null ? "30" : timeout
    });
    return retStr;
  }
}
