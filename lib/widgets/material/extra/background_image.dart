import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final Widget child;

  const BackgroundImage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/mygold/bg6.png'), // Path to your image
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
