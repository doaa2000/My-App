import 'user.dart';

class Datum {
  String? accessToken;
  String? refreshToken;
  User? user;

  Datum({this.accessToken, this.refreshToken, this.user});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        accessToken: json['access_token'] as String?,
        refreshToken: json['refresh_token'] as String?,
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'access_token': accessToken,
        'refresh_token': refreshToken,
        'user': user?.toJson(),
      };
}
