import 'package:dio/dio.dart';

import '../errors/failure.dart';
import 'api_response_code.dart';
import 'api_response_messages.dart';


/// A class containing a static method for handling DioException and mapping it to a Failure object.
///
///  It contains a static method [handleAPIError] for handling DioException
///  and mapping it to a Failure object. This class is designed to handle
///  various error scenarios and provide meaningful failure information based
///  on the type of exception.
abstract class APIErrorHandler {
  /// Handle DioException and return a corresponding Failure object.
  static Failure handleAPIError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return const Failure(
          APIResponseCode.connectTimeout,
          APIResponseMessages.connectTimeout,
        );
      case DioExceptionType.sendTimeout:
        return const Failure(
          APIResponseCode.sendTimeout,
          APIResponseMessages.sendTimeout,
        );
      case DioExceptionType.receiveTimeout:
        return const Failure(
          APIResponseCode.receiveTimeout,
          APIResponseMessages.receiveTimeout,
        );
      case DioExceptionType.badResponse:
        final errorMessage = dioException.response?.data['message'];
        switch (dioException.response?.statusCode) {
        // Success responses
          case APIResponseCode.success:
            return Failure(
              APIResponseCode.success,
              errorMessage ?? APIResponseMessages.success,
            );
          case APIResponseCode.noContent:
            return Failure(
              APIResponseCode.noContent,
              errorMessage ?? APIResponseMessages.noContent,
            );

        // Client errors
          case APIResponseCode.badRequest:
            return Failure(
              APIResponseCode.badRequest,
              errorMessage ?? APIResponseMessages.badRequest,
            );
          case APIResponseCode.conflict:
            return Failure(
              APIResponseCode.conflict,
              errorMessage ?? APIResponseMessages.conflict,
            );
          case APIResponseCode.methodNotAllowed:
            return Failure(
              APIResponseCode.methodNotAllowed,
              errorMessage ?? APIResponseMessages.conflict,
            );
          case APIResponseCode.unauthorized:
            return Failure(
              APIResponseCode.unauthorized,
              errorMessage ?? APIResponseMessages.unauthorized,
            );
          case APIResponseCode.forbidden:
            return Failure(
              APIResponseCode.forbidden,
              errorMessage ?? APIResponseMessages.forbidden,
            );
          case APIResponseCode.notFound:
            return Failure(
              APIResponseCode.notFound,
              errorMessage ?? APIResponseMessages.notFound,
            );

        // Server error
          case APIResponseCode.internalServerError:
            return Failure(
              APIResponseCode.internalServerError,
              errorMessage ?? APIResponseMessages.internalServerError,
            );

        // Default case for unknown status codes
          default:
            return const Failure(
                APIResponseCode.unknown, APIResponseMessages.unknown);
        }
      case DioExceptionType.cancel:
        return const Failure(
            APIResponseCode.cancel, APIResponseMessages.cancel);
      case DioExceptionType.badCertificate:
        return const Failure(
          APIResponseCode.badRequest,
          APIResponseMessages.badRequest,
        );
      case DioExceptionType.connectionError:
        return const Failure(
            APIResponseCode.connectTimeout, APIResponseMessages.connectTimeout);
      case DioExceptionType.unknown:
        return const Failure(
          APIResponseCode.unknown,
          APIResponseMessages.unknown,
        );
    }
  }
}