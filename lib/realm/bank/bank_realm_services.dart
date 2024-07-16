import 'package:flutter/material.dart';
import 'package:mygold/realm/bank/bank.dart';
import 'package:mygold/realm/mygold_user.dart';
import 'package:realm/realm.dart';

class BankRealmServices with ChangeNotifier {
  static const String queryMyBankName = "getMyBanksSubscription";
  bool showBank = false;
  bool offlineModeOn = false;
  bool isWaiting = false;
  late Realm realm;
  User? currentUser;
  MyGoldUser? myGoldUser;

  RealmServices() {
    realm = Realm(Configuration.flexibleSync(currentUser!, [Banks.schema]));

    showBank = (realm.subscriptions.findByName(queryMyBankName) != null);

    if (realm.subscriptions.isEmpty) {
      updateSubscriptions();
    }
  }

  Future<void> updateSubscriptions() async {
    myGoldUser = await MyGoldUser.fromSecureStorage();
    realm.subscriptions.update((mutableSubscriptions) {
      mutableSubscriptions.clear();

      mutableSubscriptions.add(
          realm.query<Banks>(r'createby == $0', [myGoldUser?.email]),
          name: queryMyBankName);
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

  Future<void> close() async {
    realm.close();
  }

  @override
  void dispose() {
    realm.close();
    super.dispose();
  }

  Future<void> synchronize() async {
    await realm.syncSession.waitForDownload();
  }

  Future<RealmResults<Banks>> searchBank(String code) async {
    final results = realm.query<Banks>(
        r'createby == $0 AND bankname=$1', [myGoldUser?.email, code]);
    return results;
  }
}
