import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mygold/utils/LocalStore.dart';
import 'package:mygold/utils/ResponseData.dart';
import 'package:mygold/utils/config.dart';
import 'package:network_tools/network_tools.dart';

class ApiRequest {
  final String host;
  final String path;
  final RequestType requestType;
  final Map<String, dynamic> data;
  final bool secured;
  ApiRequest(this.path, this.requestType,
      {this.data = const {}, this.secured = true, this.host = Config.apiUrl});

  Future<ResponseData> send() async {
    late http.Response response;
    late Map<String, dynamic> querystring =
        requestType == RequestType.get ? data : {};
    String body = "";
    var url = Config.remoteServer
        ? Uri.https(host, path, querystring)
        : Uri.http("${Config.Ip}:${Config.port}", path, querystring);
    final headers = <String, String>{
      "Content-Type": "application/json",
      "project_code": Config.projectCode
    };

    if (secured) {
      LocalStore localStore = LocalStore();
      var storeValue = await localStore.read(Config.token, isList: false);
      //Map<String, dynamic> storeObj =
      // convert.jsonDecode(storeValue) as Map<String, dynamic>;

      headers['Authorization'] = "Bearer $storeValue";
      print(storeValue);
      //print(storeValue);
    }
    if (data.keys.isNotEmpty) {
      body = convert.jsonEncode(data);
    }

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bool haveNetwork = await check(host: host);

      if (haveNetwork) {
        if (requestType == RequestType.get) {
          response = await http.get(
            url,
            headers: headers,
          );
          print("*** I M AHERE");
        } else if (requestType == RequestType.post) {
          response = await http.post(url, headers: headers, body: body);
        } else if (requestType == RequestType.patch) {
          response = await http.patch(url, headers: headers, body: body);
        } else if (requestType == RequestType.delete) {
          response = await http.delete(url, headers: headers, body: body);
        }
        // print(response.headers);
        // print(response.body);
        //  print(response.statusCode);
        if (response.statusCode == 200 || response.statusCode == 201) {
          var jsonResponse =
              convert.jsonDecode(response.body) as Map<String, dynamic>;

          print(jsonResponse);
          return ResponseData(data: jsonResponse, status: true);
        } else if (response.statusCode == 204) {
          return ResponseData(data: {}, status: true);
        } else if (response.statusCode == 403) {
          return ResponseData(forceLogin: true);
        } else {
          var jsonResponse =
              convert.jsonDecode(response.body) as Map<String, dynamic>;

          // print(jsonResponse);
          var errors = getErrors(jsonResponse);

          return ResponseData(error: errors);
        }
      } else {
        return ResponseData(error: "No-Internet");
      }
    } on PlatformException catch (e) {
      return ResponseData(error: e.toString());
    }
  }

  Future<bool> check({String host = Config.apiUrl}) async {
    bool haveInternet = false;

    if (Config.remoteServer) {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());
      //var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult.contains(ConnectivityResult.mobile)) {
        haveInternet = true;
      } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
        haveInternet = true;
      } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
        haveInternet = true;
      }
      if (haveInternet) {
        try {
          final result = await InternetAddress.lookup(host);
          //print(result);
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            haveInternet = true;
          }
        } on Exception catch (_) {
          //print(err.toString());
          haveInternet = false;
        } catch (e) {
          //print(e.toString());
          haveInternet = false;
        }
      } else {
        haveInternet = false;
      }
    } else {
      haveInternet = await ipcheck();
    }

    return haveInternet;
  }

  ipcheck() async {
    bool isOk = false;
    try {
      isOk = await PortScanner.isOpen(Config.Ip, Config.port).then((value) {
        final OpenPort deviceWithOpenPort = value!.openPorts[0];

        if (deviceWithOpenPort.isOpen) {
          return true;
        } else {
          return false;
        }
      });
    } catch (_) {
      isOk = false;
    }
    return isOk;
  }

  String getErrors(Map<String, dynamic> jsonResponse) {
    if (jsonResponse.containsKey("errors")) {
      return jsonResponse["errors"];
    } else if (jsonResponse.containsKey("error")) {
      return jsonResponse["error"];
    } else if (jsonResponse.containsKey("err")) {
      return jsonResponse["err"];
    } else if (jsonResponse.containsKey("errs")) {
      return jsonResponse["errs"];
    } else {
      return "something is wrong";
    }
  }
}
