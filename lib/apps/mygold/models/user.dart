import 'package:jwt_decoder/jwt_decoder.dart';

class User {
  final String email, name, image;

  User(this.email, this.name, this.image);

  static User getOne(String token) {
    Map<String, dynamic> user = JwtDecoder.decode(token);
    return User(
        user["email"], user["name"], "./users/images/${user["userId"]}.jpg");
  }
}
