/*
* File : Login
* Version : 1.0.0
* */

import 'package:flutter/material.dart';
import 'package:mygold/apps/auth/controller/member_controller.dart';
import 'package:mygold/apps/auth/forgot_password1_screen.dart';
import 'package:mygold/apps/auth/register1_screen.dart';
import 'package:mygold/helpers/extensions/string.dart';
import 'package:mygold/helpers/theme/app_theme.dart';
import 'package:mygold/helpers/widgets/my_button.dart';
import 'package:mygold/helpers/widgets/my_spacing.dart';
import 'package:mygold/helpers/widgets/my_text.dart';
import 'package:mygold/widgets/material/appbar/App_bar.dart';
import 'package:mygold/widgets/material/extra/background_image.dart';
import 'package:mygold/widgets/material/extra/loading.dart';
import 'package:mygold/widgets/material/extra/my_box.dart';
import 'package:mygold/widgets/material/extra/top_section.dart';
import 'package:mygold/widgets/material/form/text_field.dart';
import 'package:provider/provider.dart';

class Login1Screen extends StatefulWidget {
  const Login1Screen({super.key});

  @override
  _Login1ScreenState createState() => _Login1ScreenState();
}

class _Login1ScreenState extends State<Login1Screen> {
  late CustomTheme customTheme;
  late ThemeData theme;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    // theme = AppTheme.theme;
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    final memberController = Provider.of<MemberService>(context);
    return Scaffold(
        appBar: MyAppBar(
          "login".tr(),
          canBack: false,
        ),
        body: BackgroundImage(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: <Widget>[
              TopSection(title: "login".tr(), theme: theme),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: MyBox(
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      EditTextField(
                        hintText: "email_mobile".tr(),
                        controller: username,
                        prefixIcon: Icons.email,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      EditTextField(
                        hintText: "password".tr(),
                        controller: password,
                        prefixIcon: Icons.password,
                        isPassword: true,
                      ),
                      GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.only(top: 20),
                          alignment: Alignment.centerRight,
                          child: MyText.bodySmall("forget_password".tr(),
                              fontWeight: 500),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPassword1Screen()),
                          );
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: memberController.loading
                            ? const Loading()
                            : MyButton(
                                elevation: 0,
                                borderRadiusAll: 4,
                                padding: MySpacing.xy(20, 20),
                                onPressed: () {
                                  memberController.authenticate(
                                      username.text.toLowerCase(),
                                      password.text,
                                      context);
                                },
                                child: MyText.labelMedium("login".tr(),
                                    fontWeight: 600,
                                    color: theme.colorScheme.onPrimary,
                                    letterSpacing: 0.5)),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 24),
                child: Center(
                  child: MyText.bodyMedium("new_user".tr(), fontWeight: 500),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MyButton(
                        elevation: 0,
                        borderRadiusAll: 4,
                        padding: MySpacing.xy(20, 20),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register1Screen()),
                          );
                        },
                        child: MyText.labelMedium("register".tr(),
                            fontWeight: 600,
                            color: theme.colorScheme.onPrimary,
                            letterSpacing: 0.5)),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
