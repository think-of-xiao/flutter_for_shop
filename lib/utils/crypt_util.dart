import 'dart:convert';
import 'package:crypto/crypto.dart';

//RSA字符串公钥，可以直接保存在客户端
final String PUBLIC_KEY_STR = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC0CWY8RDT4k3gTe1oq8U3nOW9Q" +
    "0/TpRTbPDHpKPmgE/MBuZ8W7XghuJCgeQs3BADOeZ3YDzfaCzQOFuy12kuQfSFl4" +
    "cNStdXGjz0YGKQlolT2HvM/p+98oh/wAZMpBYCDpn8H5QdvT2Z4GMfiIYI07q7IP" +
    "iuVxQuGrlOVRDhmviwIDAQAB";

/// Des加密key
final String DES_KEY = "u1BvOHzUOcklgNpn1MaWvdn9DT4LyzSX";
/// Des加密初始向量
final String DES_IV = "kefu1234";

// md5 加密
String generateMd5(String data) {
  var content = utf8.encode(data);
  var digest = md5.convert(content);
  return digest.toString();
}