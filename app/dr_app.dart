import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:no_dr_detection_app/app/core/constants/constants_app.dart';
import 'package:no_dr_detection_app/app/core/routes/routes.dart';
import 'package:no_dr_detection_app/app/core/theme/theme_app.dart';
import 'package:no_dr_detection_app/view/edit_history/bloc/edit_bloc.dart';
import 'package:no_dr_detection_app/view/history/bloc/history_bloc.dart';
import 'package:no_dr_detection_app/view/home/bloc/home_bloc.dart';
import 'package:no_dr_detection_app/view/login/bloc/login_bloc.dart';
import 'package:no_dr_detection_app/view/register/bloc/register_bloc.dart';

import '../view/check_your_self_screen/bloc/checking_your_self_bloc.dart';

class DiabeticRetinopathyDetectionApp extends StatelessWidget {
  DiabeticRetinopathyDetectionApp._internal();

  static DiabeticRetinopathyDetectionApp get _instance =>
      DiabeticRetinopathyDetectionApp._internal();

  factory DiabeticRetinopathyDetectionApp() => _instance;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => RegisterBloc()),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => CheckingYourSelfBloc()),
        BlocProvider(create: (context) => HistoryBloc()),
        BlocProvider(create: (context) => EditBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.generateRoute,
        initialRoute: AppConstants.splashPath,
        theme: getAppTheme(),
      ),
    );
  }
}
