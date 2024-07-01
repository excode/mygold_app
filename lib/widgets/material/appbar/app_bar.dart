import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mygold/constant.dart';
import 'package:mygold/helpers/extensions/extensions.dart';
import 'package:mygold/helpers/localizations/language.dart';
import 'package:mygold/helpers/theme/app_notifier.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool canBack;
  Language currentLanguage = Language.currentLanguage;
  List<Language> languages = Language.languages;

  MyAppBar(this.title, {this.canBack = true});

  @override
  Size get preferredSize => const Size.fromHeight(45);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: //Row(
          //children: [
          canBack
              ? IconButton(
                  icon: const Icon(Icons.arrow_back, size: 32),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
              : IconButton(
                  icon: Image.asset(
                    Constant.logo,
                    width: 32,
                    height: 32,
                  ),
                  onPressed: () {
                    //Navigator.of(context).pop();
                  }),

      titleSpacing: 0.5,
      title: Text(
        title,
        style: const TextStyle(fontSize: 17),
        textAlign: TextAlign.start,
      ),
      //elevation: 0.7,

      actions: <Widget>[
        PopupMenuButton(
          icon: const Icon(
            Icons.translate,
          ),
          itemBuilder: (BuildContext context) => popupMenuItems(),
          onSelected: (String? value) async {
            if (value == "bd" ||
                value == "en" ||
                value == "my" ||
                value == "ar" ||
                value == "de" ||
                value == "hi" ||
                value == "th" ||
                value == "ta" ||
                value == "ur" ||
                value == "es" ||
                value == "jp" ||
                value == "fr" ||
                value == "zh") {}
          },
        ),
      ],
    );
  }

  List<PopupMenuItem<String>> popupMenuItems() {
    List<PopupMenuItem<String>> menus = [];

    List<Map<String, dynamic>> menuLang = [];
    int i = 0;
    for (Language language in Language.languages) {
      menuLang.add({
        "val": language.locale.countryCode,
        "flag": "gb",
        "text": language.languageName.tr()
      });
      /*
      list.add(InkWell(
        onTap: () {
          handleRadioValueChange(language);
        },
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: <Widget>[
              Radio<Language>(
                onChanged: (dynamic value) {
                  handleRadioValueChange(language);
                },
                groupValue: currentLanguage,
                value: language,
                activeColor: themeData.colorScheme.primary,
              ),
              MyText.titleSmall(
                language.languageName,
                fontWeight: 600,
              ),
            ],
          ),
        ),
      ));
      */
    }

    String current = "en";

    for (int m = 0; m < menuLang.length; m++) {
      menus.add(PopupMenuItem(
          value: menuLang[m]["val"],
          onTap: () {
            Language lang = Language.languages[m];
            handleRadioValueChange(lang);
          },
          child: Row(
            children: <Widget>[
              /*
              ClipRRect(
                borderRadius: new BorderRadius.circular(5.0),
                child: Image.asset(
                  'assets/icons/flags/png/${menuLang[m]["flag"]}.png',
                  //package: 'country_icons',
                  scale: 3,
                ),
              ),*/
              const SizedBox(
                width: 10,
              ),
              Text(menuLang[m]["text"],
                  style: current == menuLang[m]["val"]
                      ? const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold)
                      : const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.normal)),
            ],
          )));
    }
    return menus;
  }

  Future<void> handleRadioValueChange(Language language) async {
    final AppNotifier appNotifier = GetIt.instance<AppNotifier>();
    appNotifier.changeLanguage(language);
  }
}
