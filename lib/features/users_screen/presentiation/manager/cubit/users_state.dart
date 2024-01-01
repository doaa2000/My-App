part of 'users_cubit.dart';

@immutable
sealed class UsersState {}

final class UsersInitial extends UsersState {}

final class GetUsersLoading extends UsersState {}

final class GetUsersSuccess extends UsersState {
  final UsersModel usersModel;

  GetUsersSuccess({required this.usersModel});
}

final class GetUsersFailure extends UsersState {
  final String errorMessage;

  GetUsersFailure({required this.errorMessage});
}

final class RefreshTokenExpired extends UsersState {
  final String? errorMessage;
  final bool? isTokenExpired;

  RefreshTokenExpired(
      {required this.errorMessage, required this.isTokenExpired});
}

final class RefreshTokenSuccess extends UsersState {}
