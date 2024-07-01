import 'package:flutx_ui/flutx.dart';

class Validation {
  String? validateCode(String? text) {
    text = text!.trim();
    if (text.isEmpty) {
      return "Please enter code";
    } else if (!FxStringValidator.validateString(text, includeCharacters: [
      "0",
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "0"
    ])) {
      return "Please enter valid Code";
    }
    return null;
  }

  String? validateEmail(String? text) {
    text = text!.trim();
    if (text.isEmpty) {
      return "Please enter email";
    } else if (!FxStringValidator.isEmail(text)) {
      return "Please enter valid email";
    }
    return null;
  }

  String? validateName(String? text) {
    text = text!.trim();
    if (text.isEmpty) {
      return "Please enter  name";
    }
    return null;
  }

  String? validatePassword(String? text) {
    text = text!.trim();
    if (text.isEmpty) {
      return "Please enter password";
    } else if (!FxStringValidator.validateString(text,
        includeSpecialCharacter: true,
        includeAlphabet: true,
        includeDigit: true,
        minDigit: 1,
        minAlphabet: 1,
        minLength: 6,
        maxLength: 20)) {
      return "Password must have special character and number, minimum 6 chars";
    }
    return null;
  }

  String? validateMobile(String? text) {
    text = text!.trim();
    if (text.isEmpty) {
      return "Please enter Mobile";
    } else if (!FxStringValidator.validateString(text,
        includeDigit: true,
        minDigit: 8,
        maxDigit: 20,
        maxAlphabet: 0,
        minAlphabet: 0,
        includeAlphabet: false)) {
      return "Please enter valid mobile number";
    }
    return null;
  }

  String? validateAccount(String? text) {
    text = text!.trim();
    if (text.isEmpty) {
      return "Please enter account number";
    } else if (!FxStringValidator.validateString(text, includeCharacters: [
      "0",
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "0"
    ])) {
      return "Please enter valid account number";
    }
    return null;
  }

  String? validateAmount(String? text) {
    text = text!.trim();
    if (text.isEmpty) {
      return "Please enter amount";
    } else if (!FxStringValidator.validateString(text, includeCharacters: [
      "0",
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "0"
    ])) {
      return "Number only";
    }
    return null;
  }

  bool isValidUsername(String username) {
    // Regular expression for validating a mobile number
    final RegExp mobileRegExp = RegExp(r'^\+?[0-9]{10,15}$');

    // Regular expression for validating an email address
    final RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    // Check if the username matches either of the regular expressions
    return mobileRegExp.hasMatch(username) || emailRegExp.hasMatch(username);
  }

  int validateUsername(String username) {
    // Regular expression for validating a mobile number
    final RegExp mobileRegExp = RegExp(r'^\+?[0-9]{10,15}$');

    // Regular expression for validating an email address
    final RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (mobileRegExp.hasMatch(username)) {
      return 0; // Valid mobile number
    } else if (emailRegExp.hasMatch(username)) {
      return 1; // Valid email address
    } else {
      return 2; // Neither valid mobile number nor valid email address
    }
  }
}
