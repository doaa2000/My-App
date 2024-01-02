part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {
  LoginSuccess();
}

final class LoginFailure extends AuthState {
  final String errorMessage;

  LoginFailure({required this.errorMessage});
}

final class LogoutSuccess extends AuthState {}

final class RefreshTokenExpired extends AuthState {
  final String? errorMessage;
  final bool? isTokenExpired;
  RefreshTokenExpired({this.isTokenExpired, this.errorMessage});
}

final class RefreshTokenSuccess extends AuthState {}

final class ChangeBottomNavBar extends AuthState {}
