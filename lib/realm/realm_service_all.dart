import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

// Import your schema classes
import 'package:mygold/realm/schemas.dart'; // Update with your schema file

class RealmServices with ChangeNotifier {
  final App app;
  late Realm realm;
  User? currentUser;
  bool isWaiting = false;
  Map<String, RealmResults> _loadedCollections = {};

  RealmServices(this.app) {
    _initRealm();
  }

  Future<void> _initRealm() async {
    currentUser = app.currentUser;
    if (currentUser != null) {
      final config = Configuration.flexibleSync(currentUser!, []);
      realm = Realm(config);
    }
  }

  Future<void> loadCollection<T extends RealmObject>(
      SchemaObject schema) async {
    if (!_loadedCollections.containsKey(schema.name)) {
      realm.subscriptions.update((mutableSubscriptions) {
        mutableSubscriptions.add(
          realm.query<T>(schema.name),
          name: schema.name,
        );
      });

      await realm.subscriptions.waitForSynchronization();

      final results = realm.query<T>(schema.name);
      _loadedCollections[schema.name] = results;
      notifyListeners();
    }
  }

  RealmResults<T>? getCollection<T extends RealmObject>(SchemaObject schema) {
    return _loadedCollections[schema.name] as RealmResults<T>?;
  }

  Future<void> sessionSwitch() async {
    //if (realm.syncSession.state == SyncSessionState.paused) {
    realm.syncSession.resume();
    // } else {
    //  realm.syncSession.pause();
    // }
    notifyListeners();
  }

  @override
  void dispose() {
    realm.close();
    super.dispose();
  }
}
