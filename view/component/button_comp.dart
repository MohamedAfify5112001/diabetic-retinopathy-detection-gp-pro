import 'package:flutter/material.dart';
import 'package:no_dr_detection_app/app/core/styles/app_color.dart';
import 'package:no_dr_detection_app/app/core/styles/text_weight.dart';
import 'package:no_dr_detection_app/view/component/text_comp.dart';

class ReusableButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double fontSize;
  final FontWeight? fontWeight;

  const ReusableButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.fontSize = FontsSizesManager.s20,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        elevation: const MaterialStatePropertyAll(0),
        backgroundColor: MaterialStatePropertyAll(AppColors.primaryColor),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13.0),
        child: ReusableText(
          text: text,
          textStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                color: AppColors.whiteColor,
                fontWeight: fontWeight,
                fontSize: fontSize,
                letterSpacing: 1.5,
              ),
        ),
      ),
    );
  }
}
