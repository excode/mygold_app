import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mygold/constant.dart';
import 'package:mygold/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonFunc {
  final String _baseUrl = Constant.APP_HOST;
  String encrypt(String val) {
    final plainText = val;
    final key = Key.fromUtf8(Config.edKey);
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    //final decrypted = encrypter.decrypt(encrypted, iv: iv);
    return encrypted.base64;
  }

  String decrypted(String val) {
    //final plainText = val;
    final key = Key.fromUtf8(Config.edKey);
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key));

    // final encrypted = encrypter.encrypt(plainText, iv: iv);
    final decrypted = encrypter.decrypt(Encrypted.fromBase64(val), iv: iv);
    return decrypted;
  }

  String convertToString(dynamic value) {
    // Check if the value is already a string
    if (value is String) {
      return value; // If already a string, return the value as it is
    } else {
      // If not a string, convert it to a string
      return value.toString();
    }
  }

  Future<Map<String, String>> _getCommonHeaders() async {
    print("come in common headers");
    //print("Bearer $_authToken");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _authToken = prefs.getString('accessToken') ?? '';
    return  {
      'Authorization': 'Bearer $_authToken',
      'content-type': 'application/json',
    };
  }

  Future<http.Response> post(String path, dynamic data) async {
    print("data1" + data.toString());

    final url = Uri.parse('$_baseUrl$path');

    final headers = _getCommonHeaders();

    final body = jsonEncode(data);

    final response = await http.post(url, headers: await headers, body: body);
    print("response2");
    return response;
  }

  Future<http.Response> get(String path) async {
    final url = Uri.parse('$_baseUrl$path');
    final headers = _getCommonHeaders();

    final response = await http.get(url, headers: await headers);
    return response;
  }

  Future<http.Response> patch(String path, dynamic data) async {
    final url = Uri.parse('$_baseUrl$path');
    final headers = _getCommonHeaders();
    final body = jsonEncode(data);

    final response = await http.patch(url, headers: await headers, body: body);
    return response;
  }

  String convertDateFormat(String dateStr) {
    // Check if the input string is in the expected format
    if (dateStr.length != 8) {
      return "";
    }

    // Parse the input string into a DateTime object
    DateTime dateTime = DateTime.parse(dateStr);

    // Format the DateTime object into the desired format
    final DateFormat formatter = DateFormat('yyyy/MM/dd');
    return formatter.format(dateTime);
  }

  String null2Empty(dynamic value) {
    return value ?? '';
  }

  String listSearch(List<Map<String, dynamic>> list, dynamic checkValue,
      {String field = "Description", String valueField = "ID"}) {
    String value = "";

    Map<String, dynamic> matched = list.firstWhere(
        (entry) =>
            convertToString(entry[valueField]) == convertToString(checkValue),
        orElse: () => {});

    if (matched != {}) {
      value = matched[field] ?? "";
    }
    return value;
  }
}
