import 'package:flutter/material.dart';
import 'package:no_dr_detection_app/app/core/styles/app_color.dart';
import 'package:no_dr_detection_app/app/core/styles/text_weight.dart';

class ReusableTextFormField extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onPressed;
  final bool? obscureText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const ReusableTextFormField(
      {Key? key,
      required this.hintText,
      required this.prefixIcon,
      this.suffixIcon,
      this.onPressed,
      this.obscureText,
      required this.controller,
      required this.keyboardType,
      this.validator})
      : super(key: key);

  @override
  State<ReusableTextFormField> createState() => _ReusableTextFormFieldState();
}

class _ReusableTextFormFieldState extends State<ReusableTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      obscureText: widget.obscureText ?? true,
      cursorColor: AppColors.primaryColor,
      validator: widget.validator,
      
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
        focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
        errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
        focusedErrorBorder:
            Theme.of(context).inputDecorationTheme.focusedErrorBorder,
        hintText: widget.hintText,
        hintStyle: Theme.of(context)
            .inputDecorationTheme
            .hintStyle
            ?.copyWith(fontSize: FontsSizesManager.s14),
        prefixIcon: Icon(widget.prefixIcon, size: 24.0),
        suffixIcon: widget.suffixIcon != null
            ? IconButton(
                icon: Icon(widget.suffixIcon, size: 24.0),
                onPressed: widget.onPressed,
              )
            : null,
      ),
    );
  }
}
