import 'package:flutter/material.dart';
import 'package:mygold/helpers/widgets/my_container.dart';
import 'package:mygold/helpers/widgets/my_spacing.dart';

class MyBox extends StatelessWidget {
  final Widget child;

  const MyBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MyContainer.bordered(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      color: theme.colorScheme.onSecondary,
      margin: MySpacing.all(20),
      child: child,
    );
  }
}
