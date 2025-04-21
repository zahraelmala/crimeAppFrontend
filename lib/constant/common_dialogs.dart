import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common_snackbar.dart';
import 'custom_button.dart';
import 'custom_close_button.dart';

/// A class containing static methods for displaying common dialogs.
///
/// All of the dialogs are wrapped with [Get.dialog] so no context is required.
/// It contains static methods for displaying common dialogs such as
/// error dialogs, success dialogs, loading dialogs,
/// and error dialogs with a reload action.
abstract class CommonDialogs {
  static void showErrorDialog({required String message}) {
    CommonSnackbar.showErrorSnackbar(message: message);
  }

  static void showCommonErrorDialog({required String message}) {
    Get.dialog(
      AlertDialog(
        icon: const Icon(
          Icons.close,
          size: 50,
          color: Colors.red,
        ),
        title: Text(
          message,
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
    );
  }

  /// Show a success dialog with a given message.
  static void showSuccessDialog({
    required String message,
    bool viewActions = true,
  }) {
    Get.dialog(
      AlertDialog(
        icon: const Icon(
          Icons.check,
          size: 50,
          color: Colors.green,
        ),
        title: Text(
          message,
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        actions: viewActions ? const [CustomCloseButton()] : null,
      ),
    );
  }

  static void showSuccessDialogWithActions({
    required String message,
    bool viewActions = true,
    List<Widget>? actions,
  }) {
    Get.dialog(
      AlertDialog(
        icon: const Icon(
          Icons.check,
          size: 50,
          color: Colors.green,
        ),
        title: Text(
          message,
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        actions: actions ?? (viewActions ? const [CustomCloseButton()] : null),
      ),
    );
  }

  /// Show a loading dialog.
  static void showLoadingDialog() {
    Get.dialog(
      AlertDialog(
        icon: const Icon(
          Icons.timer,
          size: 50,
          color: Colors.red,
        ),
        title: Text(
          'Please wait until processing your request',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        actions: const [
          Center(child: CircularProgressIndicator()),
        ],
      ),
      barrierDismissible: false,
    );
  }

  static void showWarningDialog({required String message}) {
    Get.dialog(
      AlertDialog(
        icon: const Icon(
          Icons.warning,
          size: 50,
          color: Colors.yellow,
        ),
        title: Text(
          message,
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
    );
  }

  static Future<bool?> showConfirmDelete(
      BuildContext context, String label) async {
    Completer<bool?> completer = Completer<bool?>();
    final user = FirebaseAuth.instance.currentUser;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          icon: const Icon(
            Icons.warning,
            size: 50,
            color: Colors.red,
          ),
          title: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Are you sure you want to delete User",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                TextSpan(
                  text: " $label?",
                  style: TextStyle(fontSize: 18, color: Colors.red),
                )
              ]
            )
          ),
          actions: [
            CustomButton(
              label: 'No',
              buttonColor: Colors.grey,
              textColor: Colors.white,
              width: 100,
              onTap: () {
                completer.complete(false);
                Get.back();
              },
            ),
            CustomButton(
              label: 'Yes',
              buttonColor: Colors.red,
              textColor: Colors.white,
              width: 100,
              onTap: () async {
                await user?.delete();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
                completer.complete(true);
                Get.back();
              },
            ),
          ],
        );
      },
    );

    return completer.future;
  }
}
