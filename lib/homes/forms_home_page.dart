/*
* File : Forms Home Page
* Version : 1.0.0
* */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mygold/helpers/theme/app_theme.dart';
import 'package:mygold/helpers/widgets/my_spacing.dart';
import 'package:mygold/helpers/widgets/my_text.dart';
import 'package:mygold/widgets/material/form/address_form_widget.dart';
import 'package:mygold/widgets/material/form/checkbox_widget.dart';
import 'package:mygold/widgets/material/form/date_picker_widget.dart';
import 'package:mygold/widgets/material/form/feedback_form_widget.dart';
import 'package:mygold/widgets/material/form/form_widget.dart';
import 'package:mygold/widgets/material/form/personal_information_form_widget.dart';
import 'package:mygold/widgets/material/form/radio_widget.dart';
import 'package:mygold/widgets/material/form/slider_widget.dart';
import 'package:mygold/widgets/material/form/switch_widget.dart';
import 'package:mygold/widgets/material/form/text_field_widget.dart';
import 'package:mygold/widgets/material/form/time_picker_widget.dart';

// ignore: always_use_package_imports
import 'single_grid_item.dart';

class FormsHomePage extends StatefulWidget {
  @override
  _FormsHomePageState createState() => _FormsHomePageState();
}

class _FormsHomePageState extends State<FormsHomePage> {
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
    return GetBuilder(
      tag: 'forms_home_page',
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(
                LucideIcons.chevronLeft,
                size: 20,
              ),
            ),
            title: MyText.titleMedium("Forms", fontWeight: 600),
          ),
          body: ListView(
            shrinkWrap: true,
            padding: MySpacing.x(20),
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              MyText.titleSmall("Inputs", fontWeight: 700),
              GridView.count(
                crossAxisCount: 2,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                padding: MySpacing.top(20),
                mainAxisSpacing: 20,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                children: <Widget>[
                  SinglePageItem(
                    title: "Text Fields",
                    icon: './assets/icons/reader-outline.png',
                    navigation: TextFieldWidget(),
                  ),
                  SinglePageItem(
                    title: "Checkbox",
                    icon: './assets/icons/reader-outline.png',
                    navigation: CheckboxWidget(),
                  ),
                  SinglePageItem(
                    title: "Radio Button",
                    icon: './assets/icons/reader-outline.png',
                    navigation: RadioWidget(),
                  ),
                  SinglePageItem(
                    icon: './assets/icons/reader-outline.png',
                    title: "Switch",
                    navigation: SwitchWidget(),
                  ),
                  SinglePageItem(
                    title: "Date Picker",
                    icon: './assets/icons/reader-outline.png',
                    navigation: DatePickerWidget(),
                  ),
                  SinglePageItem(
                    icon: './assets/icons/reader-outline.png',
                    title: "Time Picker",
                    navigation: TimePickerWidget(),
                  ),
                  SinglePageItem(
                    title: "Range Slider",
                    icon: './assets/icons/reader-outline.png',
                    navigation: SliderWidget(),
                  ),
                  SinglePageItem(
                    title: "Form",
                    icon: './assets/icons/reader-outline.png',
                    navigation: FormWidget(),
                  ),
                ],
              ),
              MySpacing.height(20),
              MyText.titleSmall("Customs", fontWeight: 700),
              GridView.count(
                crossAxisCount: 2,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                padding: MySpacing.y(20),
                mainAxisSpacing: 16.0,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 16.0,
                children: <Widget>[
                  SinglePageItem(
                    title: "Personal",
                    icon: './assets/icons/reader-outline.png',
                    navigation: PersonalInformationFormWidget(),
                  ),
                  SinglePageItem(
                    title: "Address",
                    icon: './assets/icons/reader-outline.png',
                    navigation: AddressFormWidget(),
                  ),
                  SinglePageItem(
                    title: "Feedback",
                    icon: './assets/icons/reader-outline.png',
                    navigation: FeedbackFormWidget(),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
