part of 'edit_bloc.dart';

abstract class EditEvent {}

class EditPatientRecordEvent extends EditEvent {
  final HistoryModel historyModel;

  EditPatientRecordEvent({required this.historyModel});
}

class SelectEditImageEvent extends EditEvent {}

class RemoveEditImageEvent extends EditEvent {}

class UploadingEditImageAndGetURLEvent extends EditEvent {}


