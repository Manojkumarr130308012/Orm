import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive({
    super.key,
    this.tablet,
    this.mobile,
    this.desktop,
  });
  final Widget? tablet;
  final Widget? mobile;
  final Widget? desktop;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth >= 1100) {
          return desktop!;
        } else {
          if (constraints.maxWidth >= 650) return tablet!;
          return mobile!;
        }
      },
    );
  }

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
          MediaQuery.of(context).size.width >= 650;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > 1100;
}
