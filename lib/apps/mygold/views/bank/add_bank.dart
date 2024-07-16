import 'package:flutter/material.dart';
import 'package:mygold/apps/mygold/controller/mygold_controller.dart';
import 'package:mygold/helpers/extensions/string.dart';
import 'package:mygold/helpers/theme/app_theme.dart';
import 'package:mygold/helpers/widgets/my_button.dart';
import 'package:mygold/helpers/widgets/my_spacing.dart';
import 'package:mygold/helpers/widgets/my_text.dart';
import 'package:mygold/locator.dart';
import 'package:mygold/realm/bank/bank.dart';
import 'package:mygold/widgets/material/appbar/app_bar.dart';
import 'package:mygold/widgets/material/extra/background_image.dart';
import 'package:mygold/widgets/material/extra/loading.dart';
import 'package:mygold/widgets/material/extra/my_box.dart';
import 'package:mygold/widgets/material/form/dropdown_field.dart';
import 'package:mygold/widgets/material/form/text_field.dart';

class AddBankScreen extends StatefulWidget {
  final Banks? bank;
  AddBankScreen({this.bank});
  @override
  __BankScreenState createState() => __BankScreenState();
}

class __BankScreenState extends State<AddBankScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;
  final _formKey = GlobalKey<FormState>();
  TextEditingController account_number = TextEditingController();
  TextEditingController account_name = TextEditingController();

  TextEditingController bank_name = TextEditingController();
  TextEditingController bank_branch = TextEditingController();

  TextEditingController bank_address = TextEditingController();
  TextEditingController bank_postcode = TextEditingController();
  TextEditingController bank_country = TextEditingController();
  TextEditingController bank_active = TextEditingController();
  TextEditingController bank_swiftcode = TextEditingController();
  TextEditingController bank_id = TextEditingController();
  List<Map<String, dynamic>> items = [];
  Map<String, dynamic> selItem = {};
  bool active = false;
  String buttonLabel = "add";

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.myGoldTheme;
    items = [
      {"Id": 1, "Name": "Bank".tr()},
      {"Id": 2, "Name": "E-Wallet".tr()},
      {"Id": 3, "Name": "Crypto-Wallet".tr()}
    ];
    selItem = items[0];
    if (widget.bank != null) {
      bank_id.text = widget.bank!.id.toString();
      account_number.text = widget.bank!.accountnumber!;
      account_name.text = widget.bank!.accountname!;
      bank_name.text = widget.bank!.bankname!;
      bank_branch.text = widget.bank!.branchname!;
      bank_swiftcode.text = widget.bank!.swfitcode!;
      bank_address.text = widget.bank!.address!;
      bank_country.text = widget.bank!.country!;
      bank_postcode.text = widget.bank!.postcode!;
      bank_active.text = widget.bank!.active!.toString();
      selItem = items.firstWhere((i) => i["Id"] == widget.bank!.accounttype,
          orElse: () => items[0]);
      active = widget.bank!.active ?? false;
      buttonLabel = "update";
    }
  }

  @override
  Widget build(BuildContext context) {
    final mygoldService = getIt<MyGoldService>();
    return Scaffold(
        appBar: MyAppBar("add_bank".tr()),
        body: BackgroundImage(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: <Widget>[
              // TopSection(title: "add_bank".tr(), theme: theme),
              MyBox(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      DropdownField(
                        labelText: "wallet_type".tr(),
                        items: items,
                        onChanged: (value) {
                          setState(() {
                            selItem = value!;
                          });
                        },
                        selValue: selItem,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      EditTextField(
                        hintText: "account_name".tr(),
                        controller: account_name,
                        prefixIcon: Icons.people,
                        textInputType: TextInputType.datetime,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an account name'.tr();
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      EditTextField(
                        hintText: "account_number".tr(),
                        controller: account_number,
                        prefixIcon: Icons.numbers,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an account number'.tr();
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      EditTextField(
                        hintText: "bank_name".tr(),
                        controller: bank_name,
                        prefixIcon: Icons.comment_bank,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter bank/wallet name'.tr();
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      EditTextField(
                        hintText: "bank_branch".tr(),
                        controller: bank_branch,
                        prefixIcon: Icons.local_post_office_rounded,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      EditTextField(
                        hintText: "bank_swiftcode".tr(),
                        controller: bank_swiftcode,
                        prefixIcon: Icons.code,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      EditTextField(
                        hintText: "address".tr(),
                        controller: bank_address,
                        prefixIcon: Icons.add_home_work_outlined,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      EditTextField(
                        hintText: "postcode".tr(),
                        controller: bank_postcode,
                        prefixIcon: Icons.local_post_office_rounded,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      EditTextField(
                        hintText: "country".tr(),
                        controller: bank_country,
                        prefixIcon: Icons.flag_circle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text("active".tr()),
                          Switch(
                            value: active,
                            onChanged: (value) {
                              setState(() {
                                active = value;
                                bank_active.text = value ? "1" : "0";
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 24),
                          child: mygoldService.loading
                              ? const Loading()
                              : MyButton(
                                  elevation: 0,
                                  borderRadiusAll: 4,
                                  onPressed: () async {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      Map<String, dynamic> _bank = {
                                        "accounttype": selItem["Id"],
                                        "accountname": account_name.text,
                                        "accountnumber": account_number.text,
                                        "active": active,
                                        "bankname": bank_name.text,
                                        "branchname": bank_branch.text,
                                        "address": bank_address.text,
                                        "postcode": bank_postcode.text,
                                        "country": bank_country.text,
                                        "swfitcode": bank_swiftcode.text
                                      };
                                      if (bank_id.text == "") {
                                        await mygoldService.newPost(
                                            path: "/bank",
                                            data: _bank,
                                            context: context);
                                      } else {
                                        await mygoldService.update(
                                            path: "/bank",
                                            id: bank_id.text,
                                            data: _bank,
                                            context: context);
                                      }
                                    }
                                  },
                                  padding: MySpacing.xy(20, 20),
                                  child: MyText(buttonLabel.tr(),
                                      color: theme.colorScheme.onPrimary))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
