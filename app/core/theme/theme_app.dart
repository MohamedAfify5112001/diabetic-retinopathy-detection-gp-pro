// Text Theme
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:no_dr_detection_app/app/core/styles/app_color.dart';
import 'package:no_dr_detection_app/app/core/styles/text_styles.dart';
import 'package:no_dr_detection_app/app/core/styles/text_weight.dart';

OutlineInputBorder getOutlineInputBorder({required Color color}) =>
    OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: color, width: 2),
    );

InputDecorationTheme getInputDecorationTheme() => InputDecorationTheme(
      enabledBorder: getOutlineInputBorder(color: AppColors.lightGrayColor),
      focusedBorder: getOutlineInputBorder(color: AppColors.grayColor),
      errorBorder: getOutlineInputBorder(color: AppColors.lightErrorColor),
      focusedErrorBorder: getOutlineInputBorder(color: AppColors.errorColor),
      hintStyle: getMediumStyle(color: AppColors.blackColor),
    );

TextTheme _getTextTheme() => TextTheme(
      displayLarge: getBlackStyle(
          color: AppColors.blackColor, fontSize: FontsSizesManager.s16),
      headlineLarge: getExtraBoldStyle(
          color: AppColors.whiteColor, fontSize: FontsSizesManager.s16),
      titleMedium: getRegularStyle(
          color: AppColors.blackColor, fontSize: FontsSizesManager.s14),
      bodyMedium: getRegularStyle(color: AppColors.blackColor),
      titleSmall: getRegularStyle(color: AppColors.blackColor),
      headlineMedium: getMediumStyle(color: AppColors.blackColor),
    );

ThemeData getAppTheme() => ThemeData(
      useMaterial3: true,
      inputDecorationTheme: getInputDecorationTheme(),
      scaffoldBackgroundColor: AppColors.whiteColor,
      fontFamily: FontFamily.$FontFamily,
      primaryColor: AppColors.primaryColor,
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.whiteColor,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.dark)),
      textTheme: _getTextTheme(),
    );
