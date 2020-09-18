import 'package:doce_blocks/presentation/utils/cross_platform_svg.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Center(child: CrossPlatformSvg.asset('assets/logo.png', height: 40)),
    );
  }
}
