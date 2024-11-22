import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mygold/full_apps/other/cookify/views/forgot_password_screen.dart';
import 'package:mygold/full_apps/other/cookify/views/full_app.dart';
import 'package:mygold/full_apps/other/cookify/views/register_screen.dart';
import 'package:mygold/helpers/theme/app_theme.dart';
import 'package:mygold/helpers/widgets/my_button.dart';
import 'package:mygold/helpers/widgets/my_spacing.dart';
import 'package:mygold/helpers/widgets/my_text.dart';
import 'package:mygold/helpers/widgets/my_text_style.dart';

class CookifyLoginScreen extends StatefulWidget {
  @override
  _CookifyLoginScreenState createState() => _CookifyLoginScreenState();
}

class _CookifyLoginScreenState extends State<CookifyLoginScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();

    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: theme.copyWith(
          colorScheme: theme.colorScheme
              .copyWith(secondary: customTheme.cookifyPrimary.withAlpha(40))),
      child: Scaffold(
        body: Form(
          child: ListView(
            padding: MySpacing.fromLTRB(24, 100, 24, 0),
            children: [
              Icon(
                LucideIcons.menuSquare,
                color: customTheme.cookifyPrimary,
                size: 64,
              ),
              MySpacing.height(16),
              Center(
                child: MyText.headlineSmall("Log In",
                    color: customTheme.cookifyPrimary, fontWeight: 800),
              ),
              MySpacing.height(32),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  labelText: "Email Address",
                  hintText: "Email Address",
                  labelStyle: MyTextStyle.getStyle(
                    color: customTheme.cookifyPrimary,
                    fontSize: 14,
                    fontWeight: 600,
                  ),
                  hintStyle: MyTextStyle.getStyle(
                    color: customTheme.cookifyPrimary,
                    fontSize: 14,
                    fontWeight: 600,
                  ),
                  hoverColor: customTheme.cookifyPrimary,
                  fillColor: customTheme.cookifyPrimary.withAlpha(40),
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      borderSide: BorderSide.none),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      borderSide: BorderSide.none),
                  disabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      borderSide: BorderSide.none),
                  errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      borderSide: BorderSide.none),
                  contentPadding: MySpacing.all(16),
                  prefixIcon: const Icon(
                    LucideIcons.mail,
                    size: 20,
                  ),
                  prefixIconColor: customTheme.cookifyPrimary,
                  focusColor: customTheme.cookifyPrimary,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                cursorColor: customTheme.cookifyPrimary,
                autofocus: true,
              ),
              MySpacing.height(24),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  labelText: "Password",
                  hintText: "Password",
                  labelStyle: MyTextStyle.getStyle(
                    color: customTheme.cookifyPrimary,
                    fontSize: 14,
                    fontWeight: 600,
                  ),
                  hintStyle: MyTextStyle.getStyle(
                    color: customTheme.cookifyPrimary,
                    fontSize: 14,
                    fontWeight: 600,
                  ),
                  fillColor: customTheme.cookifyPrimary.withAlpha(40),
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      borderSide: BorderSide.none),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      borderSide: BorderSide.none),
                  disabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      borderSide: BorderSide.none),
                  errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      borderSide: BorderSide.none),
                  contentPadding: MySpacing.all(16),
                  prefixIcon: const Icon(
                    LucideIcons.lock,
                    size: 20,
                  ),
                  prefixIconColor: customTheme.cookifyPrimary,
                  focusColor: customTheme.cookifyPrimary,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                cursorColor: customTheme.cookifyPrimary,
                autofocus: true,
              ),
              MySpacing.height(16),
              Align(
                alignment: Alignment.centerRight,
                child: MyButton.text(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                CookifyForgotPasswordScreen()),
                      );
                    },
                    padding: MySpacing.zero,
                    splashColor: customTheme.cookifyPrimary.withAlpha(40),
                    child: MyText.labelMedium("Forgot Password?",
                        color: customTheme.cookifyPrimary)),
              ),
              MySpacing.height(16),
              MyButton.block(
                  elevation: 0,
                  borderRadiusAll: 8,
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(builder: (context) => CookifyFullApp()),
                    );
                  },
                  padding: MySpacing.y(20),
                  backgroundColor: customTheme.cookifyPrimary,
                  child: MyText.labelLarge(
                    "Log In",
                    color: customTheme.cookifyOnPrimary,
                  )),
              MySpacing.height(16),
              MyButton.text(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                          builder: (context) => CookifyRegisterScreen()),
                    );
                  },
                  splashColor: customTheme.cookifyPrimary.withAlpha(40),
                  child: MyText.labelMedium("I haven't an account",
                      decoration: TextDecoration.underline,
                      color: customTheme.cookifyPrimary))
            ],
          ),
        ),
      ),
    );
  }
}
