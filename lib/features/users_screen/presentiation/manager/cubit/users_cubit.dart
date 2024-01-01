import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:my_app/core/utils/api_services.dart';
import 'package:my_app/core/utils/end_points.dart';
import 'package:my_app/features/users_screen/data/models/users_model/users_model/users_model.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit(this._apiService) : super(UsersInitial());
  final ApiService _apiService;
  static UsersCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> fetchUsers() async {
    emit(GetUsersLoading());

    var response = await _apiService.get(endPoint: EndPoints.users);
    UsersModel usersModel = UsersModel.fromJson(response);
    emit(GetUsersSuccess(usersModel: usersModel));
  }
}
