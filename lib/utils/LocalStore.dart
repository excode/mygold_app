import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStore {
  save(String key, String data) async {
    const storage = FlutterSecureStorage();
    await storage.write(
        key: key,
        value: data,
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions());
  }

  Future<String> read(String key, {bool isList = false}) async {
    const storage = FlutterSecureStorage();
    String? data = await storage.read(
        key: key, iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
    if (data != null) {
      return data.isNotEmpty
          ? data
          : isList
              ? "[]"
              : "";
    } else {
      return isList ? "[]" : "";
    }
  }

  deleteAll() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll(
        iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
  }

  IOSOptions _getIOSOptions() => const IOSOptions(
        accountName: "mygold_app_data",
      );
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
}
