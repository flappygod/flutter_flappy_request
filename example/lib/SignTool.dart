import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:flutterflappyaes/flutterflappyaes.dart';

//加密
class SignTool {
  //对这个map进行签名
  static Future<Map> signMap(Map map) async {
    //获取到传入的data数据
    String SrvData = map["SrvData"];
    //进行加密
    String encryptedString = await Flutterflappyaes.aesEncryptCBC(
        SrvData, "3c21423u9y8d2fwf", "3c21423u9y8d2fwf");
    //加密后的字符串
    map["SrvData"] = encryptedString;
    //返回这个map
    return map;
  }

  //进行MD5加密
  static String generateMd5(String data) {
    //加密
    var content = new Utf8Encoder().convert(data);
    //加密
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }
}
