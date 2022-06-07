import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_tracker/app/ui/helpers/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../auth_controller.dart';
import '../../../repositories/user_repository.dart';

class ProfileSettingsController extends GetxController {
  final UserRepository userRepository = UserRepository();
  final AuthController authController = Get.find();
  late final user = authController.userData.value.obs;
  late final TextEditingController nameController =
      TextEditingController(text: user.value.name);
  late final TextEditingController heightController =
      TextEditingController(text: user.value.height?.toString());
  late final selectedPickUpDateTime = (user.value.dateOfBirth != null
          ? DateTime.parse(user.value.dateOfBirth ?? "")
          : DateTime.now())
      .obs;

  late final nameValue = (user.value.name ?? "").obs;
  late final heightValue = (user.value.height?.toString() ?? "").obs;

  final isSubmitting = false.obs;

  late final genderValue =
      ((user.value.isMale != null && user.value.isMale!) ? "MALE" : "FEMALE")
          .obs;
  final count = 0.obs;
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

  updateUserData() async {
    try {
      await userRepository.updateUserData(
        email: user.value.email ?? "",
        name: nameValue.value,
        height: int.parse(heightValue.value),
        isMale: user.value.isMale ?? true,
        uid: user.value.uid ?? "",
        dateOfBirth: selectedPickUpDateTime.value.toString(),
      );
      await authController.getUserData(
        checkNextRouting: false,
      );
      UIHelper.successFlushbar();
    } on FirebaseException catch (e) {
      UIHelper.errorFlushbar(
        message: e.message,
      );
    }
  }
}
