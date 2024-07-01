/*
* File : Forgot Password
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

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;
  TextEditingController resetcode = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    //theme = AppTheme.myGoldTheme;
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    final memberController = Provider.of<MemberService>(context);
    return Scaffold(
        appBar: MyAppBar(
          "reset_password".tr(),
          canBack: false,
        ),
        body: BackgroundImage(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TopSection(title: "reset_password".tr(), theme: theme),
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: MyBox(
                    child: Column(
                      children: <Widget>[
                        EditTextField(
                            hintText: "reset_code".tr(),
                            controller: resetcode,
                            prefixIcon: Icons.code),
                        const SizedBox(
                          height: 10,
                        ),
                        EditTextField(
                          hintText: "new_password".tr(),
                          controller: newPassword,
                          prefixIcon: Icons.password,
                          isPassword: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        EditTextField(
                            hintText: "confirm_password".tr(),
                            controller: confirmPassword,
                            prefixIcon: Icons.password,
                            isPassword: true),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: memberController.loading
                              ? const Loading()
                              : MyButton(
                                  elevation: 0,
                                  borderRadiusAll: 4,
                                  onPressed: () {
                                    memberController.changePasswordWithOTP("",
                                        newPassword: newPassword.text,
                                        otp: resetcode.text,
                                        confirmPassword: confirmPassword.text,
                                        context: context);
                                  },
                                  padding: MySpacing.xy(16, 20),
                                  child: MyText.labelMedium(
                                      "update_password".tr(),
                                      fontWeight: 600,
                                      color: theme.colorScheme.onPrimary,
                                      letterSpacing: 0.5)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
