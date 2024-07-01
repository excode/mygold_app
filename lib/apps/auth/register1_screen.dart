/*
* File : Register
* Version : 1.0.0
* */

import 'package:flutter/material.dart';
import 'package:mygold/apps/auth/controller/member_controller.dart';
import 'package:mygold/helpers/extensions/string.dart';
import 'package:mygold/helpers/theme/app_theme.dart';
import 'package:mygold/helpers/widgets/my_button.dart';
import 'package:mygold/helpers/widgets/my_spacing.dart';
import 'package:mygold/helpers/widgets/my_text.dart';
import 'package:mygold/widgets/material/appbar/app_bar.dart';
import 'package:mygold/widgets/material/extra/background_image.dart';
import 'package:mygold/widgets/material/extra/loading.dart';
import 'package:mygold/widgets/material/extra/my_box.dart';
import 'package:mygold/widgets/material/extra/top_section.dart';
import 'package:mygold/widgets/material/form/text_field.dart';
import 'package:provider/provider.dart';

class Register1Screen extends StatefulWidget {
  @override
  _Register1ScreenState createState() => _Register1ScreenState();
}

class _Register1ScreenState extends State<Register1Screen> {
  late CustomTheme customTheme;
  late ThemeData theme;
  TextEditingController username = TextEditingController();
  TextEditingController name = TextEditingController();

  TextEditingController password = TextEditingController();
  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.myGoldTheme;
  }

  @override
  Widget build(BuildContext context) {
    final memberController = Provider.of<MemberService>(context);
    return Scaffold(
        appBar: MyAppBar("register".tr()),
        body: BackgroundImage(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: <Widget>[
              TopSection(title: "register".tr(), theme: theme),
              MyBox(
                child: Column(
                  children: <Widget>[
                    EditTextField(
                      hintText: "name".tr(),
                      controller: name,
                      prefixIcon: Icons.people,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    EditTextField(
                      hintText: "email_mobile".tr(),
                      controller: username,
                      prefixIcon: Icons.email,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    EditTextField(
                      hintText: "password".tr(),
                      controller: password,
                      prefixIcon: Icons.password,
                      isPassword: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 24),
                        child: memberController.loading
                            ? const Loading()
                            : MyButton(
                                elevation: 0,
                                borderRadiusAll: 4,
                                onPressed: () {
                                  memberController.register(
                                      username: username.text.toLowerCase(),
                                      password: password.text,
                                      name: name.text,
                                      usernameType: 1,
                                      context: context);
                                },
                                padding: MySpacing.xy(20, 20),
                                child: MyText("register".tr(),
                                    color: theme.colorScheme.onPrimary))),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
