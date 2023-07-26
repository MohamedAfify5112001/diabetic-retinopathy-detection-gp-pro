import 'package:flutter/material.dart';
import 'package:no_dr_detection_app/app/core/styles/text_weight.dart';

TextStyle _makeTextStyle({
  required double fontSize,
  required Color color,
  required FontWeight fontWeight,
}) =>
    TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);

// Light Style
TextStyle getLightStyle(
    {double fontSize = FontsSizesManager.s12,
    FontWeight fontWeight = FontsWeightManager.$PoppinsLight,
    required Color color}) {
  final TextStyle textStyle =
      _makeTextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight);
  return textStyle;
}

// Regular Style
TextStyle getRegularStyle(
    {double fontSize = FontsSizesManager.s12,
    FontWeight fontWeight = FontsWeightManager.$PoppinsRegular,
    required Color color}) {
  final TextStyle textStyle =
      _makeTextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight);
  return textStyle;
}

TextStyle getMediumStyle(
    {double fontSize = FontsSizesManager.s12,
    FontWeight fontWeight = FontsWeightManager.$PoppinsMed,
    required Color color}) {
  final TextStyle textStyle =
      _makeTextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight);
  return textStyle;
}

TextStyle getSemiBoldStyle(
    {double fontSize = FontsSizesManager.s12,
    FontWeight fontWeight = FontsWeightManager.$PoppinsSemiBold,
    required Color color}) {
  final TextStyle textStyle =
      _makeTextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight);
  return textStyle;
}

TextStyle getBoldStyle(
    {double fontSize = FontsSizesManager.s12,
    FontWeight fontWeight = FontsWeightManager.$PoppinsBold,
    required Color color}) {
  final TextStyle textStyle =
      _makeTextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight);
  return textStyle;
}

TextStyle getBlackStyle(
    {double fontSize = FontsSizesManager.s12,
    FontWeight fontWeight = FontsWeightManager.$PoppinsBlack,
    required Color color}) {
  final TextStyle textStyle =
      _makeTextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight);
  return textStyle;
}

TextStyle getExtraBoldStyle(
    {double fontSize = FontsSizesManager.s12,
    FontWeight fontWeight = FontsWeightManager.$PoppinsExtraBold,
    required Color color}) {
  final TextStyle textStyle =
      _makeTextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight);
  return textStyle;
}
