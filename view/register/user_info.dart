import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:no_dr_detection_app/app/core/constants/assets_app.dart';
import 'package:no_dr_detection_app/view/component/empty_space.dart';
import 'package:no_dr_detection_app/view/component/image_comp.dart';
import 'package:no_dr_detection_app/view/component/text_form_field_comp.dart';
import 'package:no_dr_detection_app/view/register/register_screen.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({Key? key}) : super(key: key);

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  @override
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
            validator: (value) {
              if (value!.isEmpty) {
                return "Please Enter Your First Name";
              }
              return null;
            },
            controller: firstNameController,
            keyboardType: TextInputType.text,
            prefixIcon: Icons.person,
            hintText: "First Name",
            obscureText: false,
          ),
        ),
        putVerticalSpace(18.0),
        FadeInRightBig(
          delay: const Duration(seconds: 2),
          duration: const Duration(milliseconds: 800),
          child: ReusableTextFormField(
            obscureText: false,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please Enter Your Last Name";
              }
              return null;
            },
            controller: lastNameController,
            keyboardType: TextInputType.text,
            prefixIcon: Icons.person,
            hintText: "Last Name",
          ),
        ),
        putVerticalSpace(18.0),
        FadeInLeftBig(
          delay: const Duration(seconds: 2),
          duration: const Duration(milliseconds: 800),
          child: ReusableTextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "Please Enter Your Email";
              } else if (!value.contains("@") || !value.contains(".com")) {
                return "Please Enter Valid Email";
              }
              return null;
            },
            controller: emailController,
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.email,
            hintText: "Email",
          ),
        ),
        putVerticalSpace(18.0),
        FadeInRightBig(
          delay: const Duration(seconds: 2),
          duration: const Duration(milliseconds: 800),
          child: ReusableTextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "Please Enter Your Phone";
              }
              return null;
            },
            controller: phoneController,
            obscureText: false,
            keyboardType: TextInputType.phone,
            prefixIcon: Icons.phone,
            hintText: "Phone",
          ),
        ),
        putVerticalSpace(18.0),
      ],
    );
  }
}
