import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppNavigator {
  static void pushNamedAndRemoveUntilNavigator(
          String routeName, BuildContext context) =>
      Navigator.of(context)
          .pushNamedAndRemoveUntil(routeName, (route) => false);

  static void pushNamedNavigator(String routeName, BuildContext context) =>
      Navigator.of(context).pushNamed(routeName);

  static void pushReplacementNamedNavigator(
          String routeName, BuildContext context) =>
      Navigator.of(context).pushReplacementNamed(routeName);
}
