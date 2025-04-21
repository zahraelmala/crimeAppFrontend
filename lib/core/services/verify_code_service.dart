import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../api/dio_consumer.dart';
import '../errors/error_handler.dart';
import '../errors/failure.dart';

class VerifyCodeService extends GetxService {
  final DioConsumer dioConsumer = Get.find();

  Future<Either<Failure, bool>> sendVerifyCode({
    required String email,
  }) async {
    try {
      await dioConsumer.post(
        endpoint: '/send-verification-code/',
        data: {
          'email': email,
          'code' : 'test'
        },
      );

      return const Right(true);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, bool>> checkVerifyCode({
    required String email,
    required String code,
  }) async {
    try {
      await dioConsumer.post(
        endpoint: '/check-verification-code/',
        data: {
          'email': email,
          'code': code,
        },
      );

      return const Right(true);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

}
