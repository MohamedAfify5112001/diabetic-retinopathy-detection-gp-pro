part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class GetSpecificUserEvent extends HomeEvent {
  final String uId;

  GetSpecificUserEvent(this.uId);
}
