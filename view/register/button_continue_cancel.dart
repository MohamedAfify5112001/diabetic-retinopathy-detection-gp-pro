import 'package:flutter/material.dart';
import 'package:no_dr_detection_app/view/component/button_comp.dart';

import '../component/empty_space.dart';

class ContinueCancelButton extends StatelessWidget {
  final void Function() onPressedNext;
  final void Function() onPressedBack;
  final int currentStep;
  final int len;

  const ContinueCancelButton(
      {Key? key,
      required this.onPressedNext,
      required this.onPressedBack,
      required this.currentStep,
      required this.len})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      child: Row(
        children: [
          Expanded(
            child: ReusableButton(
              text: currentStep == len - 1 ? "Confirm" : "Next",
              onPressed: onPressedNext,
            ),
          ),
          if (currentStep != 0) putHorizontalSpace(16.0),
          if (currentStep != 0)
            Expanded(
              child: ReusableButton(
                text: "Back",
                onPressed: onPressedBack,
              ),
            )
        ],
      ),
    );
  }
}
