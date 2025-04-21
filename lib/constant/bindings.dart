import 'package:a/core/services/firebase_service.dart';
import 'package:a/core/services/post_service.dart';
import 'package:a/core/services/verify_code_service.dart';
import 'package:get/get.dart';

import '../core/api/dio_consumer.dart';

/// [AppBinding] is a class that extends [Bindings] from GetX for managing dependencies in the Flutter project.
///
/// Defines Core dependencies, Service dependencies, and
/// Controller dependencies.
class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DioConsumer());

    // Service dependencies
    Get.lazyPut(() => PostService());
    Get.lazyPut(() => VerifyCodeService());
    Get.lazyPut(() => FirebaseAuthService());
  }
}