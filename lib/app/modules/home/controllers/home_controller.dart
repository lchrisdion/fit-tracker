import 'package:fit_tracker/app/auth_controller.dart';
import 'package:fit_tracker/app/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/user_track_model.dart';
import '../../../ui/helpers/ui_helper.dart';
import '../../../ui/widgets/current_weight_dialog.dart';

class HomeController extends GetxController {
  final UserRepository userRepository = UserRepository();
  final AuthController authController = Get.find();
  late final user = authController.userData.value.obs;
  final listTrack = List<UserTrack>.empty(growable: true).obs;
  final isSubmittingWeightData = false.obs;
  final TextEditingController weightController = TextEditingController();
  final selectedPickUpDateTime = DateTime.now().obs;
  final weightValue = "".obs;
  @override
  void onInit() async {
    super.onInit();
    await firstLoad();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  firstLoad() async {
    await getUserTrackData();
    if (listTrack.isEmpty)
      await addUserWeight(
        canPop: false,
      );
    listTrack
        .bindStream(userRepository.streamTrackData(uid: user.value.uid ?? ""));
  }

  getUserTrackData() async {
    try {
      var response =
          await userRepository.getUserTrackData(uid: user.value.uid ?? "");
      listTrack.assignAll(response);
    } catch (e) {
      UIHelper.errorFlushbar();
      print(e);
    }
  }

  addUserWeight({
    bool canPop: true,
  }) async {
    try {
      await Get.dialog(
        Obx(
          () => CurrentWeightDialog(
            weightTextEditingController: weightController,
            onChange: (value) {
              weightValue.value = value;
            },
            canPop: canPop,
            isSubmitting: isSubmittingWeightData.value,
            onSubmit: () async {
              await addUserCurrentWeight();
              Get.back();
            },
            onPickedDate: (date) {
              selectedPickUpDateTime.value = date;
            },
            currentTime: selectedPickUpDateTime.value,
          ),
        ),
        barrierDismissible: canPop,
        useSafeArea: true,
      );
    } catch (e) {
      UIHelper.errorFlushbar();
    } finally {
      selectedPickUpDateTime.value = DateTime.now();
      weightValue.value = "";
      weightController.clear();
    }
  }

  addUserCurrentWeight() async {
    if (isSubmittingWeightData.value) return;
    try {
      isSubmittingWeightData.value = true;
      await userRepository.addUserTrackData(
          weight: int.parse(
            weightValue.value,
          ),
          uid: user.value.uid ?? "",
          date: selectedPickUpDateTime.value.toString());
    } catch (e) {
      print(e);
      UIHelper.errorFlushbar();
    } finally {
      isSubmittingWeightData.value = false;
    }
  }

  addTrackData(
      {required int weight, required String uid, required String date}) async {
    try {
      await userRepository.addUserTrackData(
        date: date,
        weight: weight,
        uid: uid,
      );
    } catch (e) {
      UIHelper.errorFlushbar();
    }
  }

  removeTrackData({required String date, required int index}) async {
    try {
      listTrack.removeAt(index);
      await userRepository.removeTrackData(
          uid: user.value.uid ?? "", date: date);
    } catch (e) {
      UIHelper.errorFlushbar();
    }
  }
}
