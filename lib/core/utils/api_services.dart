import 'package:dio/dio.dart';
import 'package:my_app/core/utils/constatnts.dart';
import 'package:my_app/core/utils/end_points.dart';
import 'package:fly_networking/AppException.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://uat-api.alfa-sa.co/",
    ),
  );

  // ApiService() {
  //   _dio.interceptors.add(InterceptorsWrapper(
  //     onRequest: (options, handler) async {
  //       options.headers['Content-Type'] = 'application/json';

  //       options.headers['x-api-version'] = 'v1';
  //       String token = await storage.read(key: 'accessToken') ?? '';
  //       _dio.options.headers['Authorization'] = 'Bearer $token';
  //       return handler.next(options);
  //     },
  //     onError: (error, handler) async {
  //       if (error.response?.statusCode == 401 ||
  //           error.response?.statusCode == 403) {
  //         print("hello error");
  //         await refreshToken();
  //         final newToken = await storage.read(key: 'accessToken');
  //         _dio.options.headers['Authorization'] = 'Bearer $newToken';

  //         return handler.resolve(await _dio.fetch(
  //             error.requestOptions.copyWith(validateStatus: (_) => true)));
  //       }

  //       return handler.next(error);
  //     },
  //   ));
  // }

  // Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
  //   final options = Options(
  //     method: requestOptions.method,
  //     headers: requestOptions.headers,
  //   );

  //   return _dio.request<dynamic>(
  //     requestOptions.path,
  //     data: requestOptions.data,
  //     queryParameters: requestOptions.queryParameters,
  //     options: options,
  //   );
  // }

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
      print("hello try");
      final refreshToken = await storage.read(key: 'refreshToken');
      _dio.options.headers['Authorization'] = 'Bearer $refreshToken';

      final response = await _dio.post(
        EndPoints.refreshToken,
        options: Options(headers: {
          'authorization': 'Bearer $refreshToken',
        }),
      );
      print(response.data['data']);
      print("refresh token in header $refreshToken");
      print("ggggg ${response.requestOptions.data}");
      print("response access token ${response.data['data']['access_token']}");
      final newAccessToken = await response.data['data']['access_token'];
      if (response.statusCode == 200) {
        await storage.delete(key: 'accessToken');
        await storage.write(key: 'accessToken', value: newAccessToken);

        print("new access token from api $newAccessToken");
        final newAccess = await storage.read(key: 'newAccessToken');
        print("new acces token $newAccess");
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
      print(response.data);

      if (response.data["success"] == false) {
        throw AppException(true,
            beautifulMsg: _buildErrorMsg(response.data),
            code: response.statusCode ?? 0,
            title: '');
      }
      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await refreshToken();
      }

      return {};
    }
  }

  String _buildErrorMsg(Map<String, dynamic> response) {
    return response['success'];
  }
}
