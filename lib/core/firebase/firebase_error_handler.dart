import 'package:firebase_core/firebase_core.dart';

import '../errors/failure.dart';
import 'firebase_error_codes.dart';
import 'firebase_error_messages.dart';

abstract class FirebaseErrorHandler {
  static Failure handleFirebaseErrors(FirebaseException exception) {
    switch (exception.code) {
    //* AUTH SECTION START *//
      case FirebaseErrorCodes.weakPassword:
        return const Failure(
          FirebaseErrorCodes.weakPassword,
          FirebaseErrorMessages.weakPassword,
        );
      case FirebaseErrorCodes.existAccount:
        return const Failure(
          FirebaseErrorCodes.existAccount,
          FirebaseErrorMessages.existAccount,
        );
      case FirebaseErrorCodes.emailIsUsed:
        return const Failure(
          FirebaseErrorCodes.emailIsUsed,
          FirebaseErrorMessages.existAccount,
        );
      case FirebaseErrorCodes.invalidEmail:
        return const Failure(
          FirebaseErrorCodes.invalidEmail,
          FirebaseErrorMessages.invalidEmail,
        );
      case FirebaseErrorCodes.operationNotAllowed:
        return const Failure(
          FirebaseErrorCodes.operationNotAllowed,
          FirebaseErrorMessages.operationNotAllowed,
        );
      case FirebaseErrorCodes.tooManyRequests:
        return const Failure(
          FirebaseErrorCodes.tooManyRequests,
          FirebaseErrorMessages.tooManyRequests,
        );
      case FirebaseErrorCodes.userDisabled:
        return const Failure(
          FirebaseErrorCodes.userDisabled,
          FirebaseErrorMessages.userDisabled,
        );
      case FirebaseErrorCodes.userNotFound:
        return const Failure(
          FirebaseErrorCodes.userNotFound,
          FirebaseErrorMessages.userNotFound,
        );
      case FirebaseErrorCodes.wrongPassword:
        return const Failure(
          FirebaseErrorCodes.wrongPassword,
          FirebaseErrorMessages.wrongPassword,
        );
      case FirebaseErrorCodes.invalidVerificationCode:
        return const Failure(
          FirebaseErrorCodes.invalidVerificationCode,
          FirebaseErrorMessages.invalidVerificationCode,
        );
      case FirebaseErrorCodes.invalidVerificationId:
        return const Failure(
          FirebaseErrorCodes.invalidVerificationId,
          FirebaseErrorMessages.invalidVerificationId,
        );
      case FirebaseErrorCodes.networkConnectionFailed:
        return const Failure(
          FirebaseErrorCodes.networkConnectionFailed,
          FirebaseErrorMessages.networkConnectionFailed,
        );
    //* AUTH SECTION END *//

    //* FIRESTORE SECTION START *//
      case FirebaseErrorCodes.aborted:
        return const Failure(
          FirebaseErrorCodes.aborted,
          FirebaseErrorMessages.aborted,
        );
      case FirebaseErrorCodes.alreadyExists:
        return const Failure(
          FirebaseErrorCodes.alreadyExists,
          FirebaseErrorMessages.alreadyExists,
        );
      case FirebaseErrorCodes.cancelled:
        return const Failure(
          FirebaseErrorCodes.cancelled,
          FirebaseErrorMessages.cancelled,
        );
      case FirebaseErrorCodes.dataLoss:
        return const Failure(
          FirebaseErrorCodes.dataLoss,
          FirebaseErrorMessages.dataLoss,
        );
      case FirebaseErrorCodes.deadlineExceeded:
        return const Failure(
          FirebaseErrorCodes.deadlineExceeded,
          FirebaseErrorMessages.deadlineExceeded,
        );
      case FirebaseErrorCodes.failedPrecondition:
        return const Failure(
          FirebaseErrorCodes.failedPrecondition,
          FirebaseErrorMessages.failedPrecondition,
        );
      case FirebaseErrorCodes.internal:
        return const Failure(
          FirebaseErrorCodes.internal,
          FirebaseErrorMessages.internal,
        );
      case FirebaseErrorCodes.invalidArgument:
        return const Failure(
          FirebaseErrorCodes.invalidArgument,
          FirebaseErrorMessages.invalidArgument,
        );
      case FirebaseErrorCodes.notFound:
        return const Failure(
          FirebaseErrorCodes.notFound,
          FirebaseErrorMessages.notFound,
        );
      case FirebaseErrorCodes.ok:
        return const Failure(
          FirebaseErrorCodes.ok,
          FirebaseErrorMessages.ok,
        );
      case FirebaseErrorCodes.outOfRange:
        return const Failure(
          FirebaseErrorCodes.outOfRange,
          FirebaseErrorMessages.outOfRange,
        );
      case FirebaseErrorCodes.permissionDenied:
        return const Failure(
          FirebaseErrorCodes.permissionDenied,
          FirebaseErrorMessages.permissionDenied,
        );
      case FirebaseErrorCodes.resourceExhausted:
        return const Failure(
          FirebaseErrorCodes.resourceExhausted,
          FirebaseErrorMessages.resourceExhausted,
        );
      case FirebaseErrorCodes.unauthenticated:
        return const Failure(
          FirebaseErrorCodes.unauthenticated,
          FirebaseErrorMessages.unauthenticated,
        );
      case FirebaseErrorCodes.unavailable:
        return const Failure(
          FirebaseErrorCodes.unavailable,
          FirebaseErrorMessages.unavailable,
        );
      case FirebaseErrorCodes.unimplemented:
        return const Failure(
          FirebaseErrorCodes.unimplemented,
          FirebaseErrorMessages.unimplemented,
        );
      case FirebaseErrorCodes.unknown:
        return const Failure(
          FirebaseErrorCodes.unknown,
          FirebaseErrorMessages.unknown,
        );
    //* FIRESTORE SECTION END *//

    //* CLOUD STORAGE SECTION START *//
      case FirebaseErrorCodes.unknownError:
      case FirebaseErrorCodes.objectNotFoundError:
        return const Failure(
          FirebaseErrorCodes.objectNotFoundError,
          FirebaseErrorMessages.objectNotFoundError,
        );
      case FirebaseErrorCodes.bucketNotFoundError:
        return const Failure(
          FirebaseErrorCodes.bucketNotFoundError,
          FirebaseErrorMessages.bucketNotFoundError,
        );
      case FirebaseErrorCodes.projectNotFoundError:
        return const Failure(
          FirebaseErrorCodes.projectNotFoundError,
          FirebaseErrorMessages.projectNotFoundError,
        );
      case FirebaseErrorCodes.quotaExceededError:
        return const Failure(
          FirebaseErrorCodes.quotaExceededError,
          FirebaseErrorMessages.quotaExceededError,
        );
      case FirebaseErrorCodes.unauthenticatedError:
        return const Failure(
          FirebaseErrorCodes.unauthenticatedError,
          FirebaseErrorMessages.unauthenticatedError,
        );
      case FirebaseErrorCodes.unauthorizedError:
        return const Failure(
          FirebaseErrorCodes.unauthorizedError,
          FirebaseErrorMessages.unauthorizedError,
        );
      case FirebaseErrorCodes.retryLimitExceededError:
        return const Failure(
          FirebaseErrorCodes.retryLimitExceededError,
          FirebaseErrorMessages.retryLimitExceededError,
        );
      case FirebaseErrorCodes.invalidChecksumError:
        return const Failure(
          FirebaseErrorCodes.invalidChecksumError,
          FirebaseErrorMessages.invalidChecksumError,
        );
      case FirebaseErrorCodes.canceledError:
        return const Failure(
          FirebaseErrorCodes.canceledError,
          FirebaseErrorMessages.canceledError,
        );
      case FirebaseErrorCodes.invalidEventNameError:
        return const Failure(
          FirebaseErrorCodes.invalidEventNameError,
          FirebaseErrorMessages.invalidEventNameError,
        );
      case FirebaseErrorCodes.invalidUrlError:
        return const Failure(
          FirebaseErrorCodes.invalidUrlError,
          FirebaseErrorMessages.invalidUrlError,
        );
      case FirebaseErrorCodes.invalidArgumentError:
        return const Failure(
          FirebaseErrorCodes.invalidArgumentError,
          FirebaseErrorMessages.invalidArgumentError,
        );
      case FirebaseErrorCodes.noDefaultBucketError:
        return const Failure(
          FirebaseErrorCodes.noDefaultBucketError,
          FirebaseErrorMessages.noDefaultBucketError,
        );
      case FirebaseErrorCodes.cannotSliceBlobError:
        return const Failure(
          FirebaseErrorCodes.cannotSliceBlobError,
          FirebaseErrorMessages.cannotSliceBlobError,
        );
      case FirebaseErrorCodes.serverFileWrongSizeError:
        return const Failure(
          FirebaseErrorCodes.serverFileWrongSizeError,
          FirebaseErrorMessages.serverFileWrongSizeError,
        );

    //* CLOUD STORAGE SECTION END *//

      default:
        return const Failure(
          FirebaseErrorCodes.unexpectedError,
          FirebaseErrorMessages.unexpectedError,
        );
    }
  }
}