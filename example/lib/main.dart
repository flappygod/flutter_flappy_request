import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutterflappyrequest/flutterflappyrequest.dart';

import 'SignTool.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      //platformVersion = await Flutterflappyrequest.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new GestureDetector(
          onTap: () {
            _request();
          },
          child: Center(
            child: Text('Running on: $_platformVersion\n'),
          ),
        ),
      ),
    );
  }

  //请求
  Future<void> _request() async {
    String url = "https://api.fzwl.top/clientapi/index";
    Map<String, String> userData = new Map<String, String>();
    userData["UUID"] = "1234567890";
    userData["DivName"] = "ceshi";
    userData["DivOs"] = "android";
    userData["DivAlias"] = "alias";
    //请求添加的参数
    Map<String, dynamic> headerMap = new Map<String, dynamic>();
    //暂时没有添加header参数
    Map<String, dynamic> datas = new Map<String, dynamic>();
    //请求接口路由名称
    datas["SrvCode"] = "BindUserDevice";
    //请求数据
    datas["SrvData"] = jsonEncode(userData);
    //进行加签处理
    datas = await SignTool.signMap(datas);
    //请求
    FlappyRequest request =
        new FlappyRequest(url: url, header: headerMap, body: datas);
    //请求数据
    String ret = await request.postParam();
    //打印数据
    print(ret);
  }
}
