import 'datum.dart';

class LoginModel {
  int? statusCode;
  List<Datum>? data;
  bool? success;

  LoginModel({this.statusCode, this.data, this.success});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        statusCode: json['status_code'] as int?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
            .toList(),
        success: json['success'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'status_code': statusCode,
        'data': data?.map((e) => e.toJson()).toList(),
        'success': success,
      };
}
