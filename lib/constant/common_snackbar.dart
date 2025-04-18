import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CommonSnackbar {
  static showErrorSnackbar({required String message}) {
    Get.showSnackbar(GetSnackBar(
      message: message,
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 5),
    ));
  }

  static showSuccessSnackbar({required String message}) {
    Get.showSnackbar(GetSnackBar(
      message: message,
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 3),
    ));
  }
}
