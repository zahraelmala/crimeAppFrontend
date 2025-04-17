import 'package:a/core/core/services/post_service.dart';
import 'package:get/get.dart';

import 'dio_consumer.dart';

/// [AppBinding] is a class that extends [Bindings] from GetX for managing dependencies in the Flutter project.
///
/// Defines Core dependencies, Service dependencies, and
/// Controller dependencies.
class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Core dependencies
    Get.put(DioConsumer()); // Initialize and provide a singleton instance of DioConsumer.

    // Service dependencies
    Get.lazyPut(() => PostService());
  }
}