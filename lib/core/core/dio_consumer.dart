import 'package:dio/dio.dart' as dioo;


const _baseUrl = "http://192.168.1.66:8000";

const Map<String, dynamic> _headers = {
  'Content-Type': 'application/json',
  "Access-Control-Allow-Origin": "*",
};

dioo.BaseOptions _baseOptions = dioo.BaseOptions(
  baseUrl: _baseUrl,
  headers: _headers,
  sendTimeout: const Duration(seconds: 30),
  receiveTimeout: const Duration(seconds: 30),
  connectTimeout: const Duration(seconds: 30),
);

class DioConsumer {
  late dioo.Dio dio;

  /// Constructor for DioConsumer class.
  DioConsumer() {
    // Initialize Dio instance with base options and interceptors
    dio = dioo.Dio();

    dio = dioo.Dio(_baseOptions);
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