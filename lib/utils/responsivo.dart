import 'package:flutter/material.dart';

class Responsivo extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsivo(
      {Key? key, required this.mobile, required this.desktop, this.tablet})
      : super(key: key);

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 800;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 800 &&
        MediaQuery.of(context).size.width < 1200;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 1200) {
        return desktop;
      } else if (constraints.maxWidth >= 800) {
        Widget? resultadoTablet = tablet;
        if (resultadoTablet != null) {
          return resultadoTablet;
        }
        return mobile;
      } else {
        return mobile;
      }
    });
  }
}
