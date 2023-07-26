import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:no_dr_detection_app/app/core/constants/constants_app.dart';
import 'package:no_dr_detection_app/app/core/routes/navigation.dart';
import 'package:no_dr_detection_app/view/check_your_self_screen/bloc/checking_your_self_bloc.dart';
import 'package:no_dr_detection_app/view/component/button_comp.dart';
import 'package:no_dr_detection_app/view/component/text_comp.dart';

import '../../app/core/behaviours/get_label.dart';
import '../../app/core/styles/app_color.dart';
import '../../app/core/styles/text_weight.dart';
import '../component/empty_space.dart';

class CheckingYourSelfScreen extends StatefulWidget {
  const CheckingYourSelfScreen({Key? key}) : super(key: key);

  @override
  State<CheckingYourSelfScreen> createState() => _CheckingYourSelfScreenState();
}

class _CheckingYourSelfScreenState extends State<CheckingYourSelfScreen> {
  @override
  void initState() {
    BlocProvider.of<CheckingYourSelfBloc>(context).add(LoadingModelEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckingYourSelfBloc, CheckingYourSelfState>(
      listener: (context, state) {
        if (state is UploadDRImageState) {
          BlocProvider.of<CheckingYourSelfBloc>(context)
              .add(ClassifyImageByModelEvent());
        }
      },
      builder: (context, state) {
        final prediction =
            BlocProvider.of<CheckingYourSelfBloc>(context).predictModel;
        return Scaffold(
          appBar: AppBar(
            title: ReusableText(
              text: "Check Your Patient",
              textStyle: Theme.of(context).textTheme.displayLarge!,
            ),
          ),
          body: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<CheckingYourSelfBloc>(context)
                        .add(UploadDRImageEvent());
                  },
                  child: (BlocProvider.of<CheckingYourSelfBloc>(context)
                              .pickedFile !=
                          null)
                      ? Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 14.0),
                          child: Image.file(
                            File(BlocProvider.of<CheckingYourSelfBloc>(context)
                                .pickedFile!
                                .path!),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.symmetric(horizontal: 50.0),
                          height: 200,
                          width: double.infinity,
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
                putVerticalSpace(14.0),
                (prediction.isNotEmpty && state is SuccessClassifyImageState)
                    ? Column(
                        children: [
                          Container(
                            width: 224,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.blackColor, width: 0.9),
                                color: AppColors.whiteColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0))),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    ReusableText(
                                      text:
                                          "DR Stage: ${getLabel((prediction[0]["label"] as String))}",
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .copyWith(
                                            color: AppColors.primaryColor,
                                            fontSize: 15.0,
                                          ),
                                    ),
                                    putVerticalSpace(10.0),
                                    ReusableText(
                                      text:
                                          "Percentage: ${((prediction[0]["confidence"] * 100) as double).toStringAsFixed(1)}%",
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .copyWith(
                                            color: AppColors.primaryColor,
                                            fontSize: 15.0,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          putVerticalSpace(16.0),
                          SizedBox(
                            width: 224,
                            child: ReusableButton(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              onPressed: () {
                                AppNavigator.pushReplacementNamedNavigator(
                                    AppConstants.detailsPath, context);
                              },
                              text: "Show Details",
                            ),
                          ),
                        ],
                      )
                    : (BlocProvider.of<CheckingYourSelfBloc>(context)
                                .pickedFile ==
                            null)
                        ? const SizedBox.shrink()
                        : Center(
                            child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          )),
              ],
            ),
          ),
        );
      },
    );
  }
}
