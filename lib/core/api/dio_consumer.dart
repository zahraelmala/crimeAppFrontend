import 'package:dio/dio.dart' as dioo;

const String _baseUrl = "http://10.0.2.2:8000";

dioo.BaseOptions _baseOptions = dioo.BaseOptions(
  baseUrl: _baseUrl,
  headers: {
    'Content-Type': 'application/json',
    "Access-Control-Allow-Origin": "*",
  },
  sendTimeout: const Duration(seconds: 30),
  receiveTimeout: const Duration(seconds: 30),
  connectTimeout: const Duration(seconds: 30),
);

class DioConsumer {
  late dioo.Dio dio;
  String? _idToken;

  /// Constructor for DioConsumer class.
  DioConsumer() {
    dio = dioo.Dio(_baseOptions);
  }

  /// Method to update the Authorization token
  void updateToken(String token) {
    _idToken = token;
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  /// Make a GET request to the specified endpoint.
  Future<dioo.Response> get({
    required String endpoint,
    Map<String, dynamic>? queryParams,
  }) async {
    return await dio.get(
      endpoint,
      queryParameters: queryParams,
    );
  }

  /// Make a POST request to the specified endpoint.
  Future<dioo.Response> post({
    required String endpoint,
    Map<String, dynamic>? queries,
    dynamic data,
  }) async {
    return await dio.post(
      endpoint,
      queryParameters: queries,
      data: data,
    );
  }

  /// Make a PUT request to the specified endpoint.
  Future<dioo.Response> put({
    required String endpoint,
    Map<String, dynamic>? queries,
    Map<String, dynamic>? data,
  }) async {
    return await dio.put(
      endpoint,
      queryParameters: queries,
      data: data,
    );
  }

  /// Make a DELETE request to the specified endpoint.
  Future<dioo.Response> delete({
    required String endpoint,
    Map<String, dynamic>? queries,
    Map<String, dynamic>? data,
  }) async {
    return await dio.delete(
      endpoint,
      queryParameters: queries,
      data: data,
    );
  }

  /// Make a PATCH request to the specified endpoint.
  Future<dioo.Response> patch({
    required String endpoint,
    Map<String, dynamic>? queries,
    Map<String, dynamic>? data,
  }) async {
    return await dio.patch(
      endpoint,
      queryParameters: queries,
      data: data,
    );
  }
}
