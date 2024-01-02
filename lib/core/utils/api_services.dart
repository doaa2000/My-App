import 'package:dio/dio.dart';
import 'package:my_app/core/utils/constatnts.dart';
import 'package:my_app/core/utils/end_points.dart';
import 'package:fly_networking/AppException.dart';
import 'package:get/get.dart';
import 'package:my_app/features/login_screen/presentiation/views/login_view.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://uat-api.alfa-sa.co/",
    ),
  );

  Future<Map<String, dynamic>> post(
      {required String endPoint, data, String? authorization}) async {
    try {
      bool hasInternet = await InternetConnectionChecker().hasConnection;
      if (hasInternet) {
        var response = await _dio.post(endPoint,
            data: data,
            options: Options(
              headers: {"Authorization": authorization},
            ));

        Map<String, dynamic> responseData = {
          'payload': response.data,
          'status': response.statusCode
        };
        if (response.data['success'] == false) {
          throw AppException(true,
              beautifulMsg: _buildErrorMsg(response.data),
              code: response.statusCode ?? 0,
              title: '');
        }
        return responseData;
      }
      throw ('No Internet Connection');
    } on DioException catch (e) {
      throw AppException(true,
          beautifulMsg: _buildErrorMsg(e.response?.data['error']),
          code: e.response?.statusCode ?? 0,
          title: '');
    }
  }

  Future<String> refreshToken() async {
    try {
      final refreshToken = await storage.read(key: 'refreshToken');
      _dio.options.headers['Authorization'] = 'Bearer $refreshToken';

      final response = await _dio.post(
        EndPoints.refreshToken,
        options: Options(headers: {
          'authorization': 'Bearer $refreshToken',
        }),
      );

      final newAccessToken = await response.data['data']['access_token'];
      if (response.statusCode == 200) {
        await storage.delete(key: 'accessToken');
        await storage.write(key: 'accessToken', value: newAccessToken);
      }

      return newAccessToken;
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        storage.deleteAll();
        Get.to(() => const LoginView());
      } else {
        throw AppException(true,
            beautifulMsg: _buildErrorMsg(error.response?.data['error']),
            code: error.response?.statusCode ?? 0,
            title: '');
      }
      return error.toString();
    }
  }

  Future<Map<String, dynamic>> get(
      {required String endPoint, String? authorization}) async {
    String token = await storage.read(key: 'accessToken') ?? '';

    _dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      bool hasInternet = await InternetConnectionChecker().hasConnection;
      if (hasInternet) {
        var response = await _dio.get(
          endPoint,
        );
        if (response.data['success'] == false) {}
        return response.data;
      }
      throw ('No Internet Connection');
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await refreshToken();
        return await get(endPoint: endPoint, authorization: 'Bearer $token');
      } else {
        throw AppException(true,
            beautifulMsg: _buildErrorMsg(e.response?.data['error']),
            code: e.response?.statusCode ?? 0,
            title: '');
      }
    }
  }

  String _buildErrorMsg(String response) {
    return response;
  }
}
