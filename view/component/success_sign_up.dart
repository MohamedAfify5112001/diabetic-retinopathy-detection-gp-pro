import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:no_dr_detection_app/app/core/constants/assets_app.dart';
import 'package:no_dr_detection_app/app/core/constants/constants_app.dart';
import 'package:no_dr_detection_app/app/core/routes/navigation.dart';
import 'package:no_dr_detection_app/app/core/styles/app_color.dart';
import 'package:no_dr_detection_app/view/component/text_comp.dart';

import '../component/image_comp.dart';

class SuccessSignUp extends StatefulWidget {
  const SuccessSignUp({Key? key}) : super(key: key);

  @override
  State<SuccessSignUp> createState() => _SuccessSignUpState();
}

class _SuccessSignUpState extends State<SuccessSignUp> {
  late Timer _timer;

  void _successSignUpDelay() {
    _timer = Timer(const Duration(seconds: 6), _nextScreen);
  }

  void _nextScreen() {
    AppNavigator.pushNamedAndRemoveUntilNavigator(
        AppConstants.loginPath, context);
  }

  @override
  void initState() {
    super.initState();
    _successSignUpDelay();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 280,
            height: 280,
            child: Lottie.asset("assets/json/88860-success-animation.json"),
          ),
          Center(
            child: ReusableText(
              text:
                  "Congralulatíons, your account \n has been successfully created",
              textStyle: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: AppColors.primaryColor, height: 1.4),
            ),
          )
        ],
      ),
    );
  }
}
