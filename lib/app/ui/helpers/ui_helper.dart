import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UIHelper {
  static String currentFlushBarMessage = "";
  static void errorFlushbar({String? message: "Something went wrong"}) async {
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
        backgroundColor: Colors.red[300]!,
      );
      await Future.delayed(Duration(seconds: 4)).then((value) {
        currentFlushBarMessage = '';
      });
    }
  }

  static void successFlushbar({String? message: "Success"}) async {
    if (currentFlushBarMessage != message && !Get.isSnackbarOpen) {
      currentFlushBarMessage = message ?? "Success";
      Get.rawSnackbar(
        messageText: Text(
          message ?? "Success",
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
        backgroundColor: Colors.green[300]!,
      );
      await Future.delayed(Duration(seconds: 4)).then((value) {
        currentFlushBarMessage = '';
      });
    }
  }
}
