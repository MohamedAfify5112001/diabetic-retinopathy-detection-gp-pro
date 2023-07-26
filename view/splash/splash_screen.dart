import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:no_dr_detection_app/app/caching/cache_helper.dart';
import 'package:no_dr_detection_app/app/core/constants/assets_app.dart';
import 'package:no_dr_detection_app/app/core/constants/constants_app.dart';
import 'package:no_dr_detection_app/app/core/routes/navigation.dart';

import '../component/image_comp.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  late String $UID = CacheHelper.getValue(key: AppConstants.MYUID).isEmpty
      ? ""
      : CacheHelper.getValue(key: AppConstants.MYUID);

  void _splashDelay() {
    _timer = Timer(const Duration(seconds: 8), _nextScreen);
  }

  void _nextScreen() {
    if ($UID.isNotEmpty) {
      AppNavigator.pushNamedAndRemoveUntilNavigator(
          AppConstants.homePath, context);
    } else {
      AppNavigator.pushNamedAndRemoveUntilNavigator(
          AppConstants.loginPath, context);
    }
  }

  @override
  void initState() {
    super.initState();
    _splashDelay();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeInRightBig(
          delay: const Duration(seconds: 2),
          duration: const Duration(seconds: 1),
          child: AssetImageComponent(
            path: AppAssets.splashImagePath,
            width: 390,
            height: 390,
          ),
        ),
      ),
    );
  }
}
