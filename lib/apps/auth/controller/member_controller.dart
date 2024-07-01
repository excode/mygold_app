import 'package:flutter/material.dart';
import 'package:mygold/apps/auth/login1_screen.dart';
import 'package:mygold/apps/auth/otp_verification_screen.dart';
import 'package:mygold/apps/auth/reset_password1_screen.dart';
import 'package:mygold/apps/mygold/views/dashboard.dart';
//import 'package:mygold/full_apps/other/homemade/views/home_screen.dart';
import 'package:mygold/helpers/extensions/extensions.dart';
import 'package:mygold/helpers/extensions/string.dart';
import 'package:mygold/utils/LocalStore.dart';
import 'package:mygold/utils/ResponseData.dart';
import 'package:mygold/utils/apiRequest.dart';
import 'package:mygold/utils/config.dart';
import 'package:mygold/utils/validation.dart';

class MemberService with ChangeNotifier {
  bool loading = false;
  bool refreshing = false;

  MemberService();

  Future<void> register(
      {required String username,
      required String password,
      required String name,
      required int usernameType,
      required BuildContext context}) async {
    loading = true;
    notifyListeners();
    Validation validation = Validation();
    try {
      int usernameType = validation.validateUsername(username);
      Map<String, dynamic> data = {
        "contactNumber": username,
        "password": password,
        "name": name
      };
      ApiRequest apiRequest = ApiRequest("/reg2", RequestType.post,
          data: data, secured: false, host: Config.apiUrlUser);

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
        localStore.save("username", username);
        localStore.save("name", name);
        localStore.save("usernameType", usernameType.toString());
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Login1Screen()),
          (Route<dynamic> route) => false,
        );
      } else {
        alertError(context, result.error);
      }
    } catch (e) {
      alertError(context, e);
    }
  }

  Future<void> update(
      {required Map<String, dynamic> data,
      required BuildContext context,
      String uid = ""}) async {
    loading = true;
    notifyListeners();
    try {
      ApiRequest apiRequest = ApiRequest("/users", RequestType.patch,
          data: data, host: Config.apiUrlUser);

      ResponseData result = await apiRequest.send();
      loading = false;
      notifyListeners();
      if (result.status) {
        /*
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  uid.length > 3 ? BottomNavBar() : KycImageScreen()),
        );
        */
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

  Future<void> uploadDocument(
      {required String fileName,
      required String documentType,
      required String fileData,
      required BuildContext context}) async {
    loading = true;
    notifyListeners();

    try {
      Map<String, dynamic> data = {
        "fileName": fileName,
        "documentType": documentType,
        "fileData": fileData
      };
      ApiRequest apiRequest =
          ApiRequest("/users/upload", RequestType.post, data: data);

      ResponseData result = await apiRequest.send();

      loading = false;
      notifyListeners();

      if (result.status) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('upload_successful'.tr()),
            duration: const Duration(seconds: 2),
          ),
        );
      } else if (result.forceLogin) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Login1Screen()),
          (Route<dynamic> route) => false,
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

  Future<void> authenticate(
      String username, String password, BuildContext context) async {
    loading = false;
    notifyListeners();
    try {
      LocalStore localStore = LocalStore();
      String refreshToken = await localStore.read(username);
      Map<String, dynamic> data = {
        "username": username,
        "password": password,
        "_x": refreshToken.isNotEmpty ? "1" : "0"
      };
      ApiRequest apiRequest = ApiRequest("/auth", RequestType.post,
          data: data, host: Config.apiUrlUser, secured: false);

      ResponseData result = await apiRequest.send();

      if (result.status) {
        localStore.save(Config.userId, result.data["userId"]);
        localStore.save(Config.username, username);
        if (refreshToken.isNotEmpty) {
          data = {"refresh_token": refreshToken};
          apiRequest = ApiRequest("/refreshMytoken", RequestType.post,
              data: data, host: Config.apiUrlUser, secured: false);

          ResponseData isVerified = await apiRequest.send();

          loading = false;
          notifyListeners();
          if (isVerified.status) {
            localStore.save(username, isVerified.data["refreshToken"]);
            localStore.save(Config.token, isVerified.data["accessToken"]);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Dashboard()),
              (Route<dynamic> route) => false,
            );
          }
        } else {
          loading = false;
          notifyListeners();

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OTPVerificationScreen()),
          );
        }
      } else {
        alertError(context, result.error.tr());
      }
    } catch (e) {
      alertError(context, e);
      print(e);
    }
  }

  Future<void> verifyOTP(String otp, BuildContext context) async {
    loading = true;
    notifyListeners();
    try {
      LocalStore localStore = LocalStore();
      String username = await localStore.read(Config.username);
      Map<String, dynamic> data = {"username": username, "otp": otp};
      ApiRequest apiRequest = ApiRequest("/authVerify", RequestType.post,
          data: data, host: Config.apiUrlUser, secured: false);

      ResponseData result = await apiRequest.send();

      loading = false;
      notifyListeners();
      if (result.status) {
        localStore.save(username, result.data["refreshToken"]);
        localStore.save(Config.token, result.data["accessToken"]);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
          (Route<dynamic> route) => false,
        );
      } else {
        alertError(context, result.error.tr());
        print("false");
      }
    } catch (e) {
      loading = false;
      notifyListeners();
      alertError(context, e);

      print(e);
    }
  }

  Future<void> resendOTP(
      String username, String userId, BuildContext context) async {
    refreshing = true;
    notifyListeners();
    LocalStore localStore = LocalStore();
    if (username == "") {
      username = await localStore.read(Config.username);
    }
    if (userId == "") {
      userId = await localStore.read(Config.userId);
    }
    try {
      Map<String, dynamic> data = {"contactNumber": username, "userId": userId};
      ApiRequest apiRequest = ApiRequest("/resendOTP", RequestType.post,
          data: data, host: Config.apiUrlUser, secured: false);

      ResponseData result = await apiRequest.send();
      refreshing = false;
      notifyListeners();
      if (result.status) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text("resent_otp".tr()),
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        alertError(context, "try_agin_in_5_minutes".tr());
      }
    } catch (e) {
      refreshing = false;
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
          content: Text('Failed Alert: ${e.toString()}'),
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

  Future<dynamic> alertLog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('logout'.tr()),
          content: Text('sure_logout'.tr()),
          actions: <Widget>[
            TextButton(
              child: Text('yes'.tr()),
              onPressed: () async {
                logout();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Login1Screen()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
            TextButton(
              child: Text('no'.tr()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> changePassword(
      {required String newPassword,
      required String oldPassword,
      required String confirmPassword,
      required BuildContext context}) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    loading = true;
    notifyListeners();
    try {
      Map<String, dynamic> data = {
        "newPassword": newPassword,
        "password": oldPassword,
        "confirmPassword": confirmPassword
      };
      ApiRequest apiRequest = ApiRequest("/changePassword", RequestType.post,
          data: data, host: Config.apiUrlUser);
      ResponseData result = await apiRequest.send();
      loading = false;
      notifyListeners();
      if (result.status) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text("password_changed".tr()),
            duration: const Duration(seconds: 2),
          ),
        );
        logout();

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Login1Screen()),
          (Route<dynamic> route) => false,
        );
      } else if (result.forceLogin) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Login1Screen()),
          (Route<dynamic> route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(result.error),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(e.toString()),
          duration: const Duration(seconds: 2),
        ),
      );
    }
    loading = false;
    notifyListeners();
  }

  Future<void> changePasswordWithOTP(String username,
      {required String newPassword,
      required String otp,
      required String confirmPassword,
      required BuildContext context}) async {
    loading = true;
    notifyListeners();
    if (username == "") {
      LocalStore localStore = LocalStore();
      username = await localStore.read(Config.username);
    }
    try {
      Map<String, dynamic> data = {
        "contactNumber": username,
        "otp": otp,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword
      };
      ApiRequest apiRequest = ApiRequest("/changePassword2", RequestType.post,
          data: data, host: Config.apiUrlUser, secured: false);
      ResponseData result = await apiRequest.send();
      loading = false;
      notifyListeners();

      if (result.status) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text("password_changed".tr()),
            duration: const Duration(seconds: 2),
          ),
        );

        logout();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login1Screen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(result.error),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      loading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(e.toString()),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<String> sendPasswordResetOTP(
      String username, BuildContext context) async {
    loading = true;
    notifyListeners();
    try {
      Map<String, dynamic> data = {"contactNumber": username};
      ApiRequest apiRequest = ApiRequest("/resendOTPFP", RequestType.post,
          data: data, secured: false, host: Config.apiUrlUser);
      ResponseData result = await apiRequest.send();
      loading = false;
      notifyListeners();

      if (result.status) {
        LocalStore localStore = LocalStore();
        localStore.save(Config.username, username);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text("reset_otp_sent".tr()),
            duration: const Duration(seconds: 2),
          ),
        );

        loading = false;
        notifyListeners();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
        );

        return "sent";
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(result.error.tr()),
            duration: const Duration(seconds: 2),
          ),
        );
        return "";
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(e.toString()),
          duration: const Duration(seconds: 2),
        ),
      );
    }
    loading = false;
    notifyListeners();
    return "";
  }
}
