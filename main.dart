import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:no_dr_detection_app/app/caching/cache_helper.dart';

import 'app/bloc_observer.dart';
import 'app/dr_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = AppBlocObserver();
  await CacheHelper.initPref();
  runApp(DiabeticRetinopathyDetectionApp());
}
