part of 'checking_your_self_bloc.dart';

@immutable
abstract class CheckingYourSelfState {}

class CheckingYourSelfInitial extends CheckingYourSelfState {}

class UploadDRImageState extends CheckingYourSelfState {}

class RemoveDRImageState extends CheckingYourSelfState {}

class SuccessLoadingModelState extends CheckingYourSelfState {}

class SuccessClassifyImageState extends CheckingYourSelfState {}

class RemovePredictionState extends CheckingYourSelfState {}
