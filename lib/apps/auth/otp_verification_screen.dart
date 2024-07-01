/*
* File : OTP verification
* Version : 1.0.0
* */

import 'package:flutter/material.dart';
import 'package:mygold/apps/auth/controller/member_controller.dart';
import 'package:mygold/apps/auth/login1_screen.dart';
import 'package:mygold/helpers/extensions/extensions.dart';
import 'package:mygold/helpers/extensions/string.dart';
import 'package:mygold/helpers/widgets/my_button.dart';
import 'package:mygold/helpers/widgets/my_text.dart';
import 'package:mygold/widgets/custom/build_info.dart';
import 'package:mygold/widgets/material/appbar/app_bar.dart';
import 'package:mygold/widgets/material/extra/background_image.dart';
import 'package:mygold/widgets/material/extra/loading.dart';
import 'package:mygold/widgets/material/extra/my_box.dart';
import 'package:mygold/widgets/material/extra/top_section.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OTPVerificationScreen extends StatefulWidget {
  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  TextEditingController otpController = TextEditingController();

  late ThemeData theme;
  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    final memberController = Provider.of<MemberService>(context);
    return Scaffold(
      //  extendBodyBehindAppBar: true,
      appBar: MyAppBar(
        "otp_verification".tr(),
        canBack: false,
      ),
      body: BackgroundImage(
        child: ListView(padding: const EdgeInsets.all(0), children: <Widget>[
          TopSection(title: "otp_verification".tr(), theme: theme),
          MyBox(
            child: Container(
              margin: EdgeInsets.only(left: 25, right: 25),
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    MyText(
                      "verification".tr(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyText(
                      "verfication_text".tr(),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Pinput(
                      length: 6,
                      showCursor: true,
                      onCompleted: (pin) {
                        otpController.text = pin;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    !memberController.loading
                        ? SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: MyButton(
                                onPressed: () {
                                  memberController.verifyOTP(
                                      otpController.text, context);
                                },
                                child: MyText(
                                  "verify_otp".tr(),
                                )),
                          )
                        : const Loading(),
                    const SizedBox(
                      height: 40,
                    ),
                    !memberController.refreshing
                        ? SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: Center(
                              child: GestureDetector(
                                  child: MyText(
                                    "resend_otp".tr(),
                                  ),
                                  onTap: () {
                                    memberController.resendOTP("", "", context);
                                  }),
                            ),
                          )
                        : const Loading(),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: Center(
                        child: GestureDetector(
                            child: MyText(
                              "sign_id".tr(),
                            ),
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login1Screen()),
                                (Route<dynamic> route) => false,
                              );
                            }),
                      ),
                    ),
                    BuildInfo()
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
