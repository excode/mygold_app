import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mygold/apps/auth/login1_screen.dart';
import 'package:mygold/helpers/extensions/extensions.dart';
import 'package:mygold/helpers/extensions/string.dart';
import 'package:mygold/utils/LocalStore.dart';
import 'package:mygold/utils/ResponseData.dart';
import 'package:mygold/utils/apiRequest.dart';
import 'package:mygold/utils/apiResponse.dart';
import 'package:mygold/utils/config.dart';
import 'package:mygold/utils/validation.dart';

class MyGoldService with ChangeNotifier {
  bool loading = false;
  bool refreshing = false;
  bool processing = false;

  MyGoldService();

  Future<void> loadBanner(
      {required String name,
      required int usernameType,
      required BuildContext context}) async {
    loading = true;
    notifyListeners();
    Validation validation = Validation();
    try {
      ApiRequest apiRequest = ApiRequest("/banners", RequestType.get);
      ResponseData result = await apiRequest.send();
      loading = false;
      notifyListeners();

      if (result.forceLogin) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Login1Screen()),
          (Route<dynamic> route) => false,
        );
      } else if (result.status) {
        LocalStore localStore = LocalStore();

        localStore.save("usernameType", usernameType.toString());
      } else {
        alertError(context, result.error);
      }
    } catch (e) {
      alertError(context, e);
    }
  }

  Future<void> update({
    required String path,
    required String id,
    required Map<String, dynamic> data,
    required BuildContext context,
  }) async {
    loading = true;
    notifyListeners();
    try {
      ApiRequest apiRequest =
          ApiRequest("$path/$id", RequestType.patch, data: data);

      ResponseData result = await apiRequest.send();
      loading = false;
      notifyListeners();
      if (result.status) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('update_successful'.tr()),
            duration: const Duration(seconds: 2),
          ),
        );
      } else if (result.forceLogin) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login1Screen()),
        );
      } else {
        alertError(context, result.error);
      }
    } catch (e) {
      loading = false;
      notifyListeners();
      alertError(context, e);

      print(e);
    }
  }

  Future<ApiResponse<T>> getList<T extends BaseModel>({
    required String path,
    required Map<String, dynamic> queryString,
    required BuildContext context,
    required T Function(Map<String, dynamic>) fromJsonT,
  }) async {
    loading = true;
    notifyListeners();
    try {
      ApiRequest apiRequest =
          ApiRequest(path, RequestType.get, data: queryString);

      ResponseData result = await apiRequest.send();
      // List<T> list =
      //  (result.data['docs'] as List).map((doc) => fromJsonT(doc)).toList();
      ApiResponse<T> respone = ApiResponse<T>.fromJson(result.data, fromJsonT);

      loading = false;
      notifyListeners();

      if (result.status) {
        return respone;
      } else if (result.forceLogin) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login1Screen()),
        );
        return ApiResponse<T>(count: 0, docs: [], perpage: 0, page: 0);
      } else {
        alertError(context, result.error);
        return ApiResponse<T>(count: 0, docs: [], perpage: 0, page: 0);
      }
    } catch (e) {
      loading = false;
      notifyListeners();
      alertError(context, e);
      return ApiResponse<T>(count: 0, docs: [], perpage: 0, page: 0);
    }
  }

  Future<T> getSingleItem<T extends BaseModel>({
    required String path,
    required String id,
    required Map<String, dynamic> queryString,
    required BuildContext context,
    required T Function(Map<String, dynamic>) fromJsonT,
  }) async {
    loading = true;
    notifyListeners();
    try {
      ApiRequest apiRequest =
          ApiRequest("$path/$id", RequestType.get, data: queryString);

      ResponseData result = await apiRequest.send();

      T response = fromJsonT(result.data);

      loading = false;
      notifyListeners();

      if (result.status) {
        return response;
      } else if (result.forceLogin) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login1Screen()),
        );
        throw Exception("Login required");
      } else {
        alertError(context, result.error);
        throw Exception(result.error);
      }
    } catch (e) {
      loading = false;
      notifyListeners();
      alertError(context, e);
      throw Exception(e);
    }
  }

  Future<void> newPost(
      {required String path,
      required Map<String, dynamic> data,
      required BuildContext context}) async {
    loading = true;
    notifyListeners();
    try {
      ApiRequest apiRequest = ApiRequest(path, RequestType.post, data: data);

      ResponseData result = await apiRequest.send();
      loading = false;
      notifyListeners();
      print(result.status);
      if (result.status) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('saved_successful'.tr()),
            duration: const Duration(seconds: 2),
          ),
        );
      } else if (result.forceLogin) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login1Screen()),
        );
      } else {
        alertError(context, result.error.tr());
      }
    } catch (e) {
      loading = false;
      notifyListeners();
      alertError(context, e);

      print(e);
    }
  }

  void logout() async {
    LocalStore localStore = LocalStore();
    String username = await localStore.read(Config.username);

    String refreshToken = await localStore.read(username);
    localStore.deleteAll();

    if (refreshToken != "") {
      localStore.save(username, refreshToken);
    }
  }

  Future<dynamic> alertError(BuildContext context, Object e) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('error'.tr()),
          content: Text('Failed: ${e.toString()}'),
          actions: <Widget>[
            TextButton(
              child: Text('ok'.tr()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
