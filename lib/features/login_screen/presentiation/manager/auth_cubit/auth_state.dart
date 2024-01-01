part of 'auth_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginFailure extends LoginState {
  final String errorMessage;

  LoginFailure({required this.errorMessage});
}

final class LogoutSuccess extends LoginState {}

final class RefreshTokenExpired extends LoginState {
  final String? errorMessage;
  final bool? isTokenExpired;
  RefreshTokenExpired({this.isTokenExpired, this.errorMessage});
}

final class RefreshTokenSuccess extends LoginState {}
