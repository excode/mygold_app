import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

class AppServices with ChangeNotifier {
  String id;
  Uri baseUrl;
  App app;
  User? currentUser;
  AppServices(this.id, this.baseUrl)
      : app = App(AppConfiguration(id, baseUrl: baseUrl)) {}

  Future<User> registerUserEmailPassword() async {
    // String email = "mylangunage@mygold.ai";
    // String password = "TeachMeLang!%";
    EmailPasswordAuthProvider authProvider = EmailPasswordAuthProvider(app);
    // await authProvider.registerUser(email, password);
    User loggedInUser = await app.logIn(Credentials.apiKey(
        "HVeFCKOZMPaGucGg3UTISLCd98nxJHvGubKEX5I997ku4lwKqqAnxwitrmDs50UV"));
    currentUser = loggedInUser;
    print("1 AM LOGGED");
    print(loggedInUser.id);
    notifyListeners();
    return loggedInUser;
  }

  Future<void> initialize() async {
    app = App(AppConfiguration(id, baseUrl: baseUrl));
    // Perform other initialization tasks if necessary
  }

  Future<void> logOut() async {
    await currentUser?.logOut();
    currentUser = null;
  }
}
