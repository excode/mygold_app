import 'package:flutter/material.dart';
import 'package:mygold/apps/mygold/views/bank/bank_list.dart';
import 'package:mygold/apps/mygold/views/home_screen.dart';
import 'package:mygold/apps/mygold/views/meal_plan_screen.dart';
import 'package:mygold/apps/mygold/views/profile_screen.dart';
import 'package:mygold/apps/mygold/views/showcase_screen.dart';
import 'package:mygold/helpers/extensions/string.dart';
import 'package:mygold/helpers/theme/app_theme.dart';
import 'package:mygold/helpers/widgets/my_bottom_navigation_bar.dart';
import 'package:mygold/helpers/widgets/my_bottom_navigation_bar_item.dart';
import 'package:mygold/helpers/widgets/my_text_style.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardAppState createState() => _DashboardAppState();
}

class _DashboardAppState extends State<Dashboard> {
  //late CustomTheme customTheme;
  late ThemeData theme;
  double titleSize = 9;

  @override
  void initState() {
    super.initState();
    // customTheme = AppTheme.customTheme;
    theme = AppTheme.myGoldTheme;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: theme.copyWith(
          colorScheme: theme.colorScheme
              .copyWith(secondary: theme.primaryColor.withAlpha(40))),
      child: Scaffold(
        body: MyBottomNavigationBar(
          activeTitleStyle:
              MyTextStyle.bodySmall(color: theme.primaryColor, fontWeight: 400),
          itemList: [
            MyBottomNavigationBarItem(
              page: CookifyHomeScreen(),
              icon: Icon(
                Icons.cottage_outlined,
                color: theme.primaryColor,
                size: 24,
              ),
              activeIcon: Icon(
                Icons.cottage,
                color: theme.primaryColor,
                size: 24,
              ),
              title: "home".tr(),
              activeTitleSize: titleSize,
              // activeIconColor: customTheme.cookifyPrimary,
            ),
            MyBottomNavigationBarItem(
              page: CookifyShowcaseScreen(),
              icon: Icon(
                Icons.store_mall_directory_outlined,
                color: theme.primaryColor,
                size: 24,
              ),
              activeIcon: Icon(
                Icons.store_mall_directory,
                color: theme.primaryColor,
                size: 24,
              ),
              title: "marketplace".tr(),
              activeTitleSize: titleSize,
              activeIconColor: theme.primaryColor,
              activeTitleColor: theme.primaryColor,
            ),
            MyBottomNavigationBarItem(
              page: const BankList(),
              icon: Icon(
                Icons.handshake_outlined,
                color: theme.primaryColor,
                size: 24,
              ),
              activeIcon: Icon(
                Icons.handshake,
                color: theme.primaryColor,
                size: 24,
              ),
              title: "contracts".tr(),
              activeTitleSize: titleSize,
              activeIconColor: theme.primaryColor,
              activeTitleColor: theme.primaryColor,
            ),
            MyBottomNavigationBarItem(
              page: CookifyMealPlanScreen(),
              icon: Icon(
                Icons.area_chart_outlined,
                color: theme.primaryColor,
                size: 24,
              ),
              activeIcon: Icon(
                Icons.area_chart,
                color: theme.primaryColor,
                size: 24,
              ),
              title: "price".tr(),
              activeTitleSize: titleSize,
              activeIconColor: theme.primaryColor,
              activeTitleColor: theme.primaryColor,
            ),
            MyBottomNavigationBarItem(
              page: CookifyProfileScreen(),
              icon: Icon(
                Icons.person_outline,
                color: theme.primaryColor,
                size: 24,
              ),
              activeIcon: Icon(
                Icons.person,
                color: theme.primaryColor,
                size: 24,
              ),
              title: "Setting",
              titleSize: titleSize,
              activeIconColor: theme.primaryColor,
              activeTitleColor: theme.primaryColor,
            ),
          ],
          activeContainerColor: theme.primaryColor.withAlpha(100),
          myBottomNavigationBarType: MyBottomNavigationBarType.normal,
          backgroundColor: theme.cardColor,
          showLabel: false,
          labelSpacing: 7,
          initialIndex: 0,
          labelDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
