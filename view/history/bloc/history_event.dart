part of 'history_bloc.dart';

@immutable
abstract class HistoryEvent {}

class SavedHistoryData extends HistoryEvent {
  final HistoryModel historyModel;

  SavedHistoryData({required this.historyModel});
}

class UploadImageHistoryData extends HistoryEvent {
  final PlatformFile platformFile;

  UploadImageHistoryData({required this.platformFile});
}

class GetHistoryDataEvent extends HistoryEvent {}
class ReturnHistoryRecordButtonEvent extends HistoryEvent {}

class DeletingHistoryEvent extends HistoryEvent {
  final String uId;

  DeletingHistoryEvent(this.uId);
}
