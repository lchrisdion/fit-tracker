import 'package:fit_tracker/app/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../ui/helpers/ui_helper.dart';

class LoginController extends GetxController {
  final AuthController authController = Get.find();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final emailValue = "".obs;
  final passwordValue = "".obs;
  final isSubmitting = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  loginUser() async {
    if (isSubmitting.value) return;
    try {
      isSubmitting.value = true;
      await authController.signUp(emailValue.value, passwordValue.value);
    } catch (e) {
      UIHelper.errorFlushbar();
      print(e);
    } finally {
      isSubmitting.value = false;
    }
  }
}
