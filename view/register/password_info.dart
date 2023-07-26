import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:no_dr_detection_app/view/component/text_form_field_comp.dart';
import 'package:no_dr_detection_app/view/register/bloc/register_bloc.dart';
import 'package:no_dr_detection_app/view/register/register_screen.dart';

import '../../app/core/constants/assets_app.dart';
import '../component/empty_space.dart';
import '../component/image_comp.dart';

class PasswordInformation extends StatefulWidget {
  const PasswordInformation({Key? key}) : super(key: key);

  @override
  State<PasswordInformation> createState() => _PasswordInformationState();
}

class _PasswordInformationState extends State<PasswordInformation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FadeInRightBig(
          child: Center(
            child: AssetImageComponent(
              path: AppAssets.splashImagePath,
              width: 310.0,
              height: 310.0,
            ),
          ),
        ),
        FadeInLeftBig(
          delay: const Duration(seconds: 2),
          duration: const Duration(milliseconds: 800),
          child: ReusableTextFormField(
            controller: passwordController,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.lock,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please Enter Password";
              }
              return null;
            },
            obscureText: context.watch<RegisterBloc>().passwordSecure,
            hintText: "Password",
            suffixIcon: BlocProvider.of<RegisterBloc>(context).passwordIconData,
            onPressed: () => BlocProvider.of<RegisterBloc>(context)
                .add(ChangeVisibilityRegisterPassword()),
          ),
        ),
        putVerticalSpace(18.0),
        FadeInRightBig(
          delay: const Duration(seconds: 2),
          duration: const Duration(milliseconds: 800),
          child: ReusableTextFormField(
            controller: confirmPasswordController,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please Enter Confirm Password";
              } else if (value != passwordController.text) {
                return "Please Enter Correct Password";
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.lock,
            obscureText: context.watch<RegisterBloc>().confirmPasswordSecure,
            hintText: "Confirm Password",
            suffixIcon:
                BlocProvider.of<RegisterBloc>(context).confirmPasswordIconData,
            onPressed: () => BlocProvider.of<RegisterBloc>(context)
                .add(ChangeVisibilityRegisterConfirmPassword()),
          ),
        ),
        putVerticalSpace(18.0),
      ],
    );
  }
}
