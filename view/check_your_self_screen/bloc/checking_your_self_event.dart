part of 'checking_your_self_bloc.dart';

@immutable
abstract class CheckingYourSelfEvent {}

class UploadDRImageEvent extends CheckingYourSelfEvent {}

class RemoveDRImageEvent extends CheckingYourSelfEvent {}

class LoadingModelEvent extends CheckingYourSelfEvent {}

class ClassifyImageByModelEvent extends CheckingYourSelfEvent {}

class RemovePredictionEvent extends CheckingYourSelfEvent {}

