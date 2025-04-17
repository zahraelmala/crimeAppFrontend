/// A class containing static constants for common API response messages.
class APIResponseMessages {
  // Success messages
  static const String success = "success"; // success with data
  static const String noContent =
      "Success but No content Found"; // success with no data

  // Failure messages
  static const String badRequest =
      "Bad request, Try again later"; // failure, API rejected request
  static const String unauthorized =
      "User is unauthorized, Try again later"; // failure, user is not authorized
  static const String forbidden =
      "Forbidden request, Try again later"; // failure, API rejected request
  static const String notFound =
      "Content not found, Try again later"; // failure, API rejected request
  static const String conflict = "There are some conflicts, Try again later";
  static const String methodNotAllowed =
      "The method is not allowed for the requested URL.";
  static const String internalServerError =
      "Something went wrong, Try again later"; // failure, crash in server side

  // Local status code messages
  static const String connectTimeout = "Time out error, Try again later";
  static const String cancel = "Request was cancelled, Try again later";
  static const String receiveTimeout = "Time out error, Try again later";
  static const String sendTimeout = "Time out error, Try again later";
  static const String cashError = "Cache error, Try again later";
  static const String noInternetConnection =
      "Please check your internet connection";
  static const String unknown = "Something went wrong, Try again later";
}