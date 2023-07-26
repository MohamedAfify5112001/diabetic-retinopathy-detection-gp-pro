part of 'history_bloc.dart';

@immutable
abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

// Save Data History States
class FailedSavingDataHistory extends HistoryState {}

class SuccessSavingDataHistory extends HistoryState {}

class LoadingSavingDataHistory extends HistoryState {}

// Uploading Image to History State

class SuccessUploadImageHistory extends HistoryState {}

class FailedUploadImageHistory extends HistoryState {}

class LoadingUploadImageHistory extends HistoryState {}

// Get History Data

class SuccessGetDataHistory extends HistoryState {}

class FailedGetDataHistory extends HistoryState {}

class LoadingGetDataHistory extends HistoryState {}

class EmptyDataHistory extends HistoryState {}

class SuccessDeleteHistory extends HistoryState {
  final List<HistoryModel> items;

  SuccessDeleteHistory(this.items);
}

class FailureDeleteHistory extends HistoryState {}

class ReturnInitialStateHistory extends HistoryState {}
