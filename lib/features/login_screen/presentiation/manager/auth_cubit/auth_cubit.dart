import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';
import 'package:my_app/core/utils/api_services.dart';
import 'package:my_app/core/utils/constatnts.dart';
import 'package:my_app/core/utils/end_points.dart';
import 'package:my_app/features/login_screen/presentiation/views/login_view.dart';
part 'auth_state.dart';

class authCubit extends Cubit<LoginState> {
  authCubit(this._apiService) : super(LoginInitial());
  final ApiService _apiService;
  static authCubit get(BuildContext context) => BlocProvider.of(context);
  Future<void> userLogin(
      {required String email, required String password}) async {
    var response = await _apiService.post(endPoint: EndPoints.login, data: {
      'email': email,
      'password': password,
    });
    emit(LoginSuccess());

    storage.write(
        key: 'refreshToken',
        value: response['payload']['data'][0]['refresh_token']);
    storage.write(
        key: 'accessToken',
        value: response['payload']['data'][0]['access_token']);
  }

  Future<void> userLogout() async {
    await storage.deleteAll().then((value) {
      emit(LogoutSuccess());
      Get.offAll(() => const LoginView());
    });
  }
}
