import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mygold/realm/schemas.dart';
import 'package:path_provider/path_provider.dart';
import 'package:realm/realm.dart';

class RealmServices with ChangeNotifier {
  static const String queryAllName = "getAllItemsSubscription";
  static const String queryMyItemsName = "getMyItemsSubscription";

  bool showAll = false;
  bool offlineModeOn = false;
  bool isWaiting = false;
  late Realm realm;
  User? currentUser;
  App app;

  RealmServices(this.app) {
    if (app.currentUser == null) {}
    if (app.currentUser != null || currentUser != app.currentUser) {
      currentUser ??= app.currentUser;

      realm = Realm(Configuration.flexibleSync(currentUser!, [Lang.schema]));
      showAll = (realm.subscriptions.findByName(queryAllName) != null);
      print("XXXXXXX");
      print(currentUser?.id);
      if (realm.subscriptions.isEmpty) {
        updateSubscriptions();
      }
    }
  }

  Future<void> updateSubscriptions() async {
    realm.subscriptions.update((mutableSubscriptions) {
      mutableSubscriptions.clear();

      mutableSubscriptions.add(
          realm.query<Lang>(r'owner_id == $0', [currentUser?.id]),
          name: queryMyItemsName);
    });

    realm
        .query<Lang>(r'owner_id == $0', [currentUser?.id])
        .changes
        .listen((changes) {
          print(")))))))))4444444)))))))");
          changes.inserted.forEach((c) {
            // Handle new additions
            print('New Lang object added: ${c}');
          });

          changes.modified.forEach((c) {
            // Handle modifications
            print('Lang object modified: ${c}');
          });

          changes.deleted.forEach((c) {
            // Handle deletions
            print('Lang object deleted: ${c}');
          });
        });
    await realm.subscriptions.waitForSynchronization();
  }

  Future<void> sessionSwitch() async {
    offlineModeOn = !offlineModeOn;
    if (offlineModeOn) {
      realm.syncSession.pause();
    } else {
      try {
        isWaiting = true;
        notifyListeners();
        realm.syncSession.resume();
        await updateSubscriptions();
      } finally {
        isWaiting = false;
      }
    }
    notifyListeners();
  }

  Future<void> switchSubscription(bool value) async {
    showAll = value;
    if (!offlineModeOn) {
      try {
        isWaiting = true;
        notifyListeners();
        await updateSubscriptions();
      } finally {
        isWaiting = false;
      }
    }
    notifyListeners();
  }

  void createItem(String key, String langCode, String content) {
    final newItem = Lang(ObjectId(), langCode, key, content, currentUser!.id,
        isDone: false);
    print(content);
    print(currentUser!.id);
    realm.write<Lang>(() => realm.add<Lang>(newItem));
    notifyListeners();
  }

  Future<void> close() async {
    if (currentUser != null) {
      await currentUser?.logOut();
      currentUser = null;
    }
    realm.close();
  }

  @override
  void dispose() {
    realm.close();
    super.dispose();
  }

  Future<void> synchronize() async {
    //await realm.syncSession.waitForDownload();
  }
  Future<RealmResults<Lang>> searchLanguage(String code) async {
    final results = realm.query<Lang>(
        r'owner_id == $0 AND langCode=$1', [currentUser?.id, code]);
    return results;
  }

  Future<void> saveLangResultsToJson(
      RealmResults<Lang> results, String code) async {
    // Convert RealmResults to a list of Maps (or however your Lang model is structured)
    // List<Map<String, dynamic>> jsonList =
    //results.map((lang) => lang.toJson()).toList();
    Map<String, dynamic> jsonMap = {"lang_code": code};
    for (Lang lang in results) {
      jsonMap = {...jsonMap, ...lang.toJson()};
    }

    // Get the directory where the app can save files
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();

    String filePath = '${appDocumentsDirectory.path}/${code}.json';
    //print("AFNAN");
    print(filePath);
    // Write JSON to file
    File jsonFile = File(filePath);
    await jsonFile.writeAsString(json.encode(jsonMap));
  }
}
