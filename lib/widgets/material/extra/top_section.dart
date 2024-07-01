import 'package:flutter/material.dart';
import 'package:mygold/constant.dart';

class TopSection extends StatelessWidget {
  final String title;
  final ThemeData theme;
  const TopSection({super.key, required this.title, required this.theme});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 1.6 / 10,
      child: Center(
        child: Image.asset(
          Constant.logo,
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
