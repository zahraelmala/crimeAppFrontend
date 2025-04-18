import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import '../api/api_error_handler.dart';
import '../api/api_response_code.dart';
import '../api/api_response_messages.dart';
import '../firebase/firebase_error_handler.dart';
import 'failure.dart';

/// A class for handling exceptions and converting them into Failure objects.
class ErrorHandler implements Exception {
  late Failure failure;

  /// Constructor for the ErrorHandler class.
  ErrorHandler.handle(dynamic error) {
    // Check if the error is a DioException
    if (error is DioException) {
      // Use APIErrorHandler to handle the DioException and obtain a Failure object
      failure = APIErrorHandler.handleAPIError(error);
    } else if (error is FirebaseException) {
      failure = FirebaseErrorHandler.handleFirebaseErrors(error);
    } else {
      // If the error is not a DioException, create a generic Failure object
      failure = const Failure(
        APIResponseCode.unknown,
        APIResponseMessages.unknown,
      );
    }
  }
}