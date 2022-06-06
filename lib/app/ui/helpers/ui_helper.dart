import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UIHelper {
  static String currentFlushBarMessage = "";
  static void errorFlushbar({String? message}) async {
    if (currentFlushBarMessage != message && !Get.isSnackbarOpen) {
      currentFlushBarMessage = message ?? "Something went wrong";
      Get.rawSnackbar(
        messageText: Text(
          message ?? "Something went wrong",
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 27,
          vertical: 22,
        ),
        snackStyle: SnackStyle.FLOATING,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
      );
      await Future.delayed(Duration(seconds: 4)).then((value) {
        currentFlushBarMessage = '';
      });
    }
  }
}
