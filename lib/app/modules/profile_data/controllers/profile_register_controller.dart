import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../auth_controller.dart';
import '../../../repositories/user_repository.dart';
import '../../../ui/helpers/ui_helper.dart';

class ProfileRegisterController extends GetxController {
  final UserRepository userRepository = UserRepository();
  final AuthController authController = Get.find();
  final String? argEmail = Get.arguments['email'];
  final String? argUID = Get.arguments['uid'];
  late final user = authController.userData.value.obs;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final selectedPickUpDateTime = DateTime.now().obs;
  final datePicked = false.obs;

  final nameValue = "".obs;
  final heightValue = "".obs;

  final isSubmitting = false.obs;

  final genderValue = "MALE".obs;
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

  addUser() async {
    if (isSubmitting.value) return;
    try {
      isSubmitting.value = true;
      await userRepository.addUserData(
        email: argEmail ?? "",
        height: int.parse(heightValue.value.removeAllWhitespace),
        isMale: genderValue.value == "MALE",
        uid: argUID ?? "",
        dateOfBirth: DateTime.now().toString(),
        name: nameValue.value,
      );
      await authController.getUserData();
    } catch (e) {
      UIHelper.errorFlushbar();
      print(e);
    } finally {
      isSubmitting.value = false;
    }
  }
}
