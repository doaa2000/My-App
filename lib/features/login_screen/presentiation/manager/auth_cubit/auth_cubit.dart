import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';
import 'package:my_app/core/utils/api_services.dart';
import 'package:my_app/core/utils/constatnts.dart';
import 'package:my_app/core/utils/end_points.dart';
import 'package:my_app/features/login_screen/data/models/login_model/login_model/user.dart';
import 'package:my_app/features/login_screen/presentiation/views/login_view.dart';
import 'package:my_app/features/login_screen/presentiation/views/widgets/home_view.dart';
import 'package:my_app/features/login_screen/presentiation/views/widgets/profile_view.dart';
import 'package:my_app/features/users_screen/presentiation/views/user_data.dart';
import 'package:fly_networking/AppException.dart';
part 'auth_state.dart';

class authCubit extends Cubit<AuthState> {
  authCubit(this._apiService) : super(AuthInitial());
  final ApiService _apiService;
  static authCubit get(BuildContext context) => BlocProvider.of(context);
  User? user;
  int currentIndex = 0;
  List<Widget> screens = [
    const HomeView(),
    const UserData(),
    const ProfileView(),
  ];

  List<String> titles = [
    'Home Screen',
    'Users Screen',
    'Profile Screen',
  ];

  Future<void> userLogin(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      var response = await _apiService.post(endPoint: EndPoints.login, data: {
        'email': email,
        'password': password,
      });
      user = User.fromJson(response['payload']['data'][0]['user']);
      emit(LoginSuccess());

      storage.write(
          key: 'refreshToken',
          value: response['payload']['data'][0]['refresh_token']);
      storage.write(
          key: 'accessToken',
          value: response['payload']['data'][0]['access_token']);
    } catch (error) {
      print(error.toString());
      if (error is AppException) {
        emit(LoginFailure(errorMessage: error.beautifulMsg ?? ''));
      }
      if (error.toString() == 'No Internet Connection') {
        emit(LoginFailure(errorMessage: 'No Internet Connection'));
      } else {
        emit(LoginFailure(errorMessage: 'SomeThing Went Wrong !'));
      }
    }
  }

  Future<void> userLogout() async {
    try {
      await storage.deleteAll().then((value) {
        emit(LogoutSuccess());
        Get.offAll(() => const LoginView());
      });
    } on Exception catch (e) {}
  }

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBar());
  }
}
