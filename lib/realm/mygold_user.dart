import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mygold/utils/LocalStore.dart';
import 'package:mygold/utils/config.dart';

class MyGoldUser {
  String userId;
  String email;
  int contactNumberType;
  String mobile;
  String contactNumber;

  MyGoldUser(
      {required this.userId,
      required this.email,
      required this.contactNumberType,
      required this.mobile,
      required this.contactNumber});

  static Future<MyGoldUser> fromSecureStorage() async {
    LocalStore localStore = LocalStore();
    final authToken = await localStore.read(Config.token);
    if (authToken == null) {
      throw Exception('Auth token not found in secure storage');
    }
    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(authToken);

      return MyGoldUser(
        userId: decodedToken['userId'] as String,
        email: decodedToken['email'] as String,
        contactNumberType: decodedToken['contactNumberType'] as int,
        mobile: decodedToken['mobile'] as String,
        contactNumber: "",
      );
    } catch (err) {
      return MyGoldUser(
        userId: "",
        email: "",
        contactNumberType: 1,
        mobile: "",
        contactNumber: "",
      );
    }
  }
}
