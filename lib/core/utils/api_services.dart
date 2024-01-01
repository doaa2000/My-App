import 'package:dio/dio.dart';
import 'package:my_app/core/utils/constatnts.dart';
import 'package:my_app/core/utils/end_points.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://uat-api.alfa-sa.co/",
    ),
  );

  Future<Map<String, dynamic>> post(
      {required String endPoint, data, String? authorization}) async {
    var response = await _dio.post(endPoint,
        data: data,
        options: Options(
          headers: {"Authorization": authorization},
        ));

    Map<String, dynamic> responseData = {
      'payload': response.data,
      'status': response.statusCode
    };

    return responseData;
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
        print('انا انتهيت');
      }
      return error.toString();
    }
  }

  Future<Map<String, dynamic>> get(
      {required String endPoint, String? authorization}) async {
    String token = await storage.read(key: 'accessToken') ?? '';
    _dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      var response = await _dio.get(
        endPoint,
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await refreshToken();
        return await get(endPoint: endPoint, authorization: 'Bearer $token');
      }

      rethrow;
    }
  }
}
