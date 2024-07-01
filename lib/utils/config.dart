import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum RequestType { post, get, patch, delete, put }

class Config {
  static String edKey = "mYGoLD@@1!@!234";
  static String accounts = "mygold_accounts";
  static String transactions = "mygold_transactions";
  static String orders = "mygold_exchangeOrders";
  static String currency = "mygold_currency";
  static String rates = "mygold_rates";
  static String marchants = "mygold_marchants";
  static String bank = "mygold_bank";
  static String token = "accessToken";
  static String userId = "userId";
  static String refresh = "refreshToken";
  static String username = "username";
  static String email = "email";
  static String name = "name";
  static String usernameType = "usernameType";
  static String banners = "mygold_banners";
  static const String apiUrl = "bomygold.azurewebsites.net"; //
  static const String apiUrlUser = "exuser.azurewebsites.net"; //
  static const String Ip = "192.168.100.30"; // ; //"fg.ikra.my";
  static const int port = 3300;
  static const String projectCode = "666d4ca255e0c45b13abd3fd";
  static bool remoteServer = true;

  static int transfer = 1;
  static int syncInterval = 2;
  static int tupup = 2;
  static int swap = 3;
  static int liquidate = 4;

  static Color golden = Color(0xFFF7D330);
  static Color goldenDark = Color.fromARGB(255, 167, 141, 25);

  static Color fiat = Color(0xFF3AA3A0);
  static Color fiatDark = Color.fromARGB(255, 11, 113, 109);
  static Color cliquidate = Color(0xFF189AB4);
  static Color cTransfer = Color(0xFF05445E);
  static Color cTopup = Color(0xFF75E6DA);
  static Color cSwap = Color(0xFFD4F1F4);

  static String codeScan = "scan";
  static String codeTransfer = "transfer";
  static String codeTopup = "topup";
  static String codeLiquidate = "liquidate";
  static String codeSwap = "swap";
  static String codeHistory = "history";

  // Convert table data to a List<Map<String, dynamic>>
}
