import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:no_dr_detection_app/app/caching/cache_helper.dart';
import 'package:no_dr_detection_app/app/core/constants/assets_app.dart';
import 'package:no_dr_detection_app/app/core/constants/constants_app.dart';
import 'package:no_dr_detection_app/app/core/routes/navigation.dart';
import 'package:no_dr_detection_app/app/core/styles/app_color.dart';
import 'package:no_dr_detection_app/app/core/styles/text_weight.dart';
import 'package:no_dr_detection_app/app/network/request.dart';
import 'package:no_dr_detection_app/view/component/empty_space.dart';
import 'package:no_dr_detection_app/view/component/image_comp.dart';
import 'package:no_dr_detection_app/view/component/text_comp.dart';
import 'package:no_dr_detection_app/view/login/bloc/login_bloc.dart';
import 'package:no_dr_detection_app/view/login/login_images_doctor.dart';

import '../../model/user_model.dart';
import '../component/button_comp.dart';
import '../component/text_form_field_comp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state is SuccessLogin) {
          await CacheHelper.putValue(key: AppConstants.MYUID, val: state.uId);
          if (!mounted) return;
          AppNavigator.pushNamedAndRemoveUntilNavigator(
              AppConstants.homePath, context);
        }
        if (state is FailureLogin) {
          if (!mounted) return;
          final snackBar = SnackBar(
              backgroundColor: Colors.red,
              content: ReusableText(
                text: state.msg,
                textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.whiteColor,
                    ),
              ));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (state is SuccessLoginGoogle) {
          CacheHelper.putValue(
                  key: AppConstants.MYUID, val: state.userGoogle.user!.uid)
              .then((value) => AppNavigator.pushNamedAndRemoveUntilNavigator(
                  AppConstants.homePath, context));
          if (!mounted) return;
          BlocProvider.of<LoginBloc>(context).add(StoringGoogleUserEvent(
            uId: state.userGoogle.user!.uid,
            userModel: UserModel(
              email: state.userGoogle.user!.email!,
              image: state.userGoogle.user!.photoURL!,
              phone: state.userGoogle.user!.phoneNumber!,
              firstName: state.userGoogle.user!.displayName!.split('')[0],
              lastName: state.userGoogle.user!.displayName!.split('')[1],
            ),
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      putVerticalSpace(50.0),
                      const LoginDoctorImages(),
                      putVerticalSpace(22.0),
                      FadeInUp(
                        delay: const Duration(seconds: 2),
                        duration: const Duration(milliseconds: 800),
                        child: ReusableTextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          obscureText: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Your Email";
                            } else if (!value.contains("@") ||
                                !value.contains(".com")) {
                              return "Please Enter Valid Email";
                            }
                            return null;
                          },
                          hintText: "Email",
                          prefixIcon: Icons.email,
                        ),
                      ),
                      putVerticalSpace(20.0),
                      FadeInUp(
                        delay: const Duration(seconds: 2),
                        duration: const Duration(milliseconds: 800),
                        child: ReusableTextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          hintText: "Password",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Password";
                            }
                            return null;
                          },
                          prefixIcon: Icons.lock,
                          onPressed: () {
                            BlocProvider.of<LoginBloc>(context)
                                .add(ChangeVisibilityEvent());
                          },
                          obscureText: context.watch<LoginBloc>().isSecure,
                          suffixIcon:
                              BlocProvider.of<LoginBloc>(context).iconData,
                        ),
                      ),
                      putVerticalSpace(30.0),
                      (state is LoadingLogin)
                          ? Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                            )
                          : FadeInLeft(
                              delay: const Duration(seconds: 3),
                              duration: const Duration(milliseconds: 800),
                              child: SizedBox(
                                width: double.infinity,
                                child: ReusableButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      BlocProvider.of<LoginBloc>(context).add(
                                        LoginInEvent(
                                          RequestSignIn(
                                              email: emailController.text,
                                              password:
                                                  passwordController.text),
                                        ),
                                      );
                                    }
                                  },
                                  text: "Sign In",
                                ),
                              ),
                            ),
                      putVerticalSpace(20.0),
                      FadeInRight(
                        delay: const Duration(seconds: 4),
                        duration: const Duration(milliseconds: 800),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ReusableText(
                              text: "Don't have an account?",
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(color: AppColors.grayColor),
                            ),
                            TextButton(
                              onPressed: () {
                                AppNavigator.pushNamedNavigator(
                                    AppConstants.registerPath, context);
                              },
                              child: ReusableText(
                                text: "Sign Up",
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(color: AppColors.primaryColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      putVerticalSpace(15.0),
                      FadeInRightBig(
                        delay: const Duration(seconds: 4),
                        duration: const Duration(milliseconds: 800),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 1.2,
                                  decoration: BoxDecoration(
                                    color: AppColors.grayColor,
                                  ),
                                ),
                              ),
                              putHorizontalSpace(5.0),
                              ReusableText(
                                text: 'OR',
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                        color: AppColors.grayColor,
                                        fontSize: FontsSizesManager.s16),
                              ),
                              putHorizontalSpace(5.0),
                              Expanded(
                                child: Container(
                                  height: 1.2,
                                  decoration: BoxDecoration(
                                    color: AppColors.grayColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      putVerticalSpace(20.0),
                      FadeInLeftBig(
                        delay: const Duration(seconds: 4),
                        duration: const Duration(milliseconds: 800),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[100],
                                radius: 33,
                                child: const AssetImageComponent(
                                  path: AppAssets.googleLogoPath,
                                  width: 40.0,
                                  height: 40.0,
                                ),
                              ),
                              onTap: () => BlocProvider.of<LoginBloc>(context)
                                  .add(GoogleLoginInEvent()),
                            ),
                            putHorizontalSpace(20.0),
                            CircleAvatar(
                              backgroundColor: Colors.grey[100],
                              radius: 33,
                              child: const AssetImageComponent(
                                path: AppAssets.facebookLogoPath,
                                width: 40.0,
                                height: 40.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
