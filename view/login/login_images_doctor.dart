import 'dart:async';

import 'package:flutter/material.dart';
import 'package:no_dr_detection_app/app/core/constants/assets_app.dart';
import 'package:no_dr_detection_app/view/component/image_comp.dart';

class LoginDoctorImages extends StatefulWidget {
  const LoginDoctorImages({Key? key}) : super(key: key);

  @override
  State<LoginDoctorImages> createState() => _LoginDoctorImagesState();
}

class _LoginDoctorImagesState extends State<LoginDoctorImages> {
  int activeIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        if (activeIndex == 3) {
          activeIndex = 0;
        } else {
          activeIndex++;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 265.0,
      child: Stack(
        children: AppAssets.imagesLogin.asMap().entries.map((e) {
          return Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: AnimatedOpacity(
              duration: const Duration(seconds: 2),
              opacity: activeIndex == e.key ? 1 : 0,
              child: AssetImageComponent(
                path: e.value,
                height: 300,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
