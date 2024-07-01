import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mygold/full_apps/m3/estate/controllers/login_controller.dart';
import 'package:mygold/helpers/theme/app_theme.dart';
import 'package:mygold/helpers/theme/constant.dart';
import 'package:mygold/helpers/widgets/my_button.dart';
import 'package:mygold/helpers/widgets/my_container.dart';
import 'package:mygold/helpers/widgets/my_spacing.dart';
import 'package:mygold/helpers/widgets/my_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ThemeData theme;
  late LogInController controller;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.estateTheme;
    controller = LogInController();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LogInController>(
        init: controller,
        tag: 'log_in_controller',
        builder: (controller) {
          return Theme(
            data: theme.copyWith(
                colorScheme: theme.colorScheme
                    .copyWith(secondary: theme.colorScheme.primaryContainer)),
            child: Scaffold(
              body: MyContainer(
                color: theme.colorScheme.primary,
                marginAll: 0,
                paddingAll: 0,
                child: MyContainer(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Constant.containerRadius.large),
                      topLeft: Radius.circular(Constant.containerRadius.large)),
                  width: MediaQuery.of(context).size.width,
                  margin: MySpacing.top(220),
                  child: ListView(
                    children: [
                      MyText.displayLarge(
                        'Log In',
                        color: theme.colorScheme.primary,
                        fontWeight: 700,
                      ),
                      MySpacing.height(24),
                      Padding(
                        padding: MySpacing.horizontal(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText.bodyLarge(
                              'Email',
                              fontWeight: 600,
                            ),
                            TextFormField(
                              controller: controller.emailController,
                              decoration: InputDecoration(
                                hintText: "Your Email Id",
                                hintStyle: TextStyle(fontSize: 12),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                contentPadding: MySpacing.fromLTRB(0, 8, 4, 20),
                                isCollapsed: true,
                                focusColor: theme.colorScheme.primary,
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                                disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              ),
                              cursorColor: theme.colorScheme.primary,
                              autofocus: true,
                            ),
                            MySpacing.height(16),
                            MyText.bodyLarge(
                              'Password',
                              fontWeight: 600,
                            ),
                            TextFormField(
                              controller: controller.passwordController,
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: TextStyle(fontSize: 12),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                contentPadding: MySpacing.fromLTRB(0, 8, 4, 20),
                                suffixIcon: InkWell(
                                  onTap: controller.onChangeShowPassword,
                                  child: Icon(
                                    controller.showPassword
                                        ? LucideIcons.eye
                                        : LucideIcons.eyeOff,
                                    size: 20,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                                suffixIconConstraints:
                                    BoxConstraints(minHeight: 0),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                                disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                                isCollapsed: true,
                                focusColor: theme.colorScheme.primary,
                              ),
                              cursorColor: theme.colorScheme.primary,
                              autofocus: true,
                            ),
                            MySpacing.height(16),
                            Align(
                              alignment: Alignment.centerRight,
                              child: MyButton.text(
                                  onPressed: () {
                                    controller.goToForgotPasswordScreen();
                                  },
                                  splashColor:
                                      theme.colorScheme.primary.withAlpha(40),
                                  child: MyText.bodySmall("Forgot Password?",
                                      color: theme.colorScheme.primary)),
                            ),
                            MySpacing.height(16),
                            MyButton.block(
                              elevation: 0,
                              borderRadiusAll: Constant.buttonRadius.large,
                              onPressed: () {
                                controller.goToHomeScreen();
                              },
                              padding: MySpacing.y(20),
                              backgroundColor: theme.colorScheme.primary,
                              child: MyText.titleMedium(
                                "LOG IN",
                                fontWeight: 700,
                                color: theme.colorScheme.onPrimary,
                                letterSpacing: 0.4,
                              ),
                            ),
                            MySpacing.height(16),
                            Center(
                              child: MyButton.text(
                                onPressed: () {
                                  controller.goToRegisterScreen();
                                },
                                splashColor:
                                    theme.colorScheme.primary.withAlpha(40),
                                child: MyText.bodySmall("I haven't an account",
                                    decoration: TextDecoration.underline,
                                    color: theme.colorScheme.primary),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}