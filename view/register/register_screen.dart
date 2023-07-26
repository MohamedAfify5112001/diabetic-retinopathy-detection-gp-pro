import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:no_dr_detection_app/app/core/styles/app_color.dart';
import 'package:no_dr_detection_app/app/core/styles/text_weight.dart';
import 'package:no_dr_detection_app/model/user_model.dart';
import 'package:no_dr_detection_app/view/component/empty_space.dart';
import 'package:no_dr_detection_app/view/component/success_sign_up.dart';
import 'package:no_dr_detection_app/view/component/text_comp.dart';
import 'package:no_dr_detection_app/view/register/bloc/register_bloc.dart';
import 'package:no_dr_detection_app/view/register/password_info.dart';
import 'package:no_dr_detection_app/view/register/user_info.dart';

import 'button_continue_cancel.dart';

final emailController = TextEditingController();
final firstNameController = TextEditingController();
final lastNameController = TextEditingController();
final phoneController = TextEditingController();
final passwordController = TextEditingController();
final confirmPasswordController = TextEditingController();

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int currentStep = 0;
  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];

  @override
  void dispose() {
    emailController.text = "";
    firstNameController.text = "";
    lastNameController.text = "";
    phoneController.text = "";
    passwordController.text = "";
    confirmPasswordController.text = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is FailedConfirmUser) {
          final snackBar = SnackBar(
              content: ReusableText(
            text: state.msg,
            textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.whiteColor,
                ),
          ));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (state is LoadingUploading) {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  backgroundColor: Colors.transparent,
                  insetPadding: const EdgeInsets.all(10),
                  child: Container(
                    width: 300,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.whiteColor),
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                );
              });
        }
        if (state is SuccessUploading) {
          BlocProvider.of<RegisterBloc>(context).add(StoringUserDataEvent(
            UserModel(
                firstName: firstNameController.text,
                lastName: lastNameController.text,
                phone: phoneController.text,
                email: emailController.text),
          ));
          BlocProvider.of<RegisterBloc>(context).add(RemoveImageEvent());
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const SuccessSignUp()),
              (route) => false);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: AppColors.whiteColor,
              colorScheme: ColorScheme.light(
                primary: AppColors.primaryColor,
              ),
            ),
            child: SafeArea(
              child: Stepper(
                physics: const BouncingScrollPhysics(),
                elevation: 1.0,
                type: StepperType.horizontal,
                steps: getSteps(context),
                currentStep: currentStep,
                controlsBuilder: (context, ControlsDetails details) {
                  return ContinueCancelButton(
                    len: getSteps(context).length,
                    currentStep: currentStep,
                    onPressedBack: details.onStepCancel!,
                    onPressedNext: details.onStepContinue!,
                  );
                },
                onStepContinue: () {
                  final isLastStep =
                      currentStep == getSteps(context).length - 1;
                  if (isLastStep) {
                    if (BlocProvider.of<RegisterBloc>(context).pickedFile ==
                        null) {
                      const text = 'Upload Photo';
                      final snackBar = SnackBar(
                          content: ReusableText(
                        text: text,
                        textStyle:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: AppColors.whiteColor,
                                ),
                      ));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      BlocProvider.of<RegisterBloc>(context).add(
                          ConfirmUserEvent(
                              emailController.text, passwordController.text));
                    }
                  } else {
                    if (_formKeys[currentStep].currentState!.validate()) {
                      setState(() {
                        currentStep += 1;
                      });
                    }
                  }
                },
                onStepCancel: () =>
                    currentStep == 0 ? null : setState(() => currentStep -= 1),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Step> getSteps(BuildContext context) => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: ReusableText(
            text: "User Info",
            textStyle: Theme.of(context).textTheme.headlineMedium!,
          ),
          content: Form(key: _formKeys[0], child: const UserInformation()),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: ReusableText(
            text: "Password",
            textStyle: Theme.of(context).textTheme.headlineMedium!,
          ),
          content: Form(key: _formKeys[1], child: const PasswordInformation()),
        ),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: ReusableText(
            text: "Photo",
            textStyle: Theme.of(context).textTheme.headlineMedium!,
          ),
          content: FadeInRightBig(
            child: GestureDetector(
              onTap: () => BlocProvider.of<RegisterBloc>(context)
                  .add(SelectImageEvent()),
              child: (BlocProvider.of<RegisterBloc>(context).pickedFile != null)
                  ? Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 14.0),
                      child: Image.file(
                        File(BlocProvider.of<RegisterBloc>(context)
                            .pickedFile!
                            .path!),
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 14.0),
                      height: 200,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.primaryColor, width: 1.5),
                          borderRadius: const BorderRadiusDirectional.all(
                              Radius.circular(10.0))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.add,
                              size: 50.0, color: AppColors.primaryColor),
                          putVerticalSpace(8.0),
                          ReusableText(
                            text: "Add Photo",
                            textStyle: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    color: AppColors.primaryColor,
                                    fontSize: FontsSizesManager.s20),
                          )
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ];
}
