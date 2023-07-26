import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:no_dr_detection_app/app/network/crud_operation.dart';

import '../../../model/user_model.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  UserModel? userModel;

  HomeBloc() : super(HomeInitial()) {
    on<GetSpecificUserEvent>((event, emit) async {
      final getJson = await CrudOperation.readOperation(
          firebaseUserId: event.uId, collectionName: "users");
      userModel = UserModel.fromJson(getJson);
      emit(GetSpecificUserState());
    });
  }
}
