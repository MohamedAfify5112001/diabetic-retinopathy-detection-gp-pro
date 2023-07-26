import 'package:flutter/material.dart';
import 'package:no_dr_detection_app/app/core/constants/constants_app.dart';
import 'package:no_dr_detection_app/view/check_your_self_screen/check_yourself_screen.dart';
import 'package:no_dr_detection_app/view/diabatic_details/diabatic_details.dart';
import 'package:no_dr_detection_app/view/edit_history/edit.dart';
import 'package:no_dr_detection_app/view/history/history.dart';
import 'package:no_dr_detection_app/view/home/home_screen.dart';
import 'package:no_dr_detection_app/view/login/login_screen.dart';
import 'package:no_dr_detection_app/view/register/register_screen.dart';

import '../../../view/splash/splash_screen.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (settings.name == AppConstants.splashPath) {
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    } else if (settings.name == AppConstants.loginPath) {
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    } else if (settings.name == AppConstants.registerPath) {
      return MaterialPageRoute(builder: (_) => const RegisterScreen());
    } else if (settings.name == AppConstants.checkPath) {
      return MaterialPageRoute(builder: (_) => const CheckingYourSelfScreen());
    } else if (settings.name == AppConstants.historyPath) {
      return MaterialPageRoute(builder: (_) => const HistoryScreen());
    } else if (settings.name == AppConstants.detailsPath) {
      return MaterialPageRoute(builder: (_) => const DiabeticDetailsScreen());
    } else {
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
