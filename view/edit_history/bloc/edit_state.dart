part of 'edit_bloc.dart';

abstract class EditState {}

class EditInitial extends EditState {}

class SelectEditingImageState extends EditState {}

class RemoveEditingImageState extends EditState {}

class LoadingEditingImageUploading extends EditState {}

class SuccessEditingImageUploading extends EditState {}

class SuccessUpdatePatientRecord extends EditState {}

class LoadingUpdatePatientRecord extends EditState {}

class FailureUpdatePatientRecord extends EditState {}
