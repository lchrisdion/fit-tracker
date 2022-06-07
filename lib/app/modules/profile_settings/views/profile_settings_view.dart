import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../ui/widgets/global_date_picker.dart';
import '../../../ui/widgets/global_loading.dart';
import '../../../ui/widgets/global_textfield.dart';
import '../controllers/profile_settings_controller.dart';

class ProfileSettingsView extends GetView<ProfileSettingsController> {
  const ProfileSettingsView({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () async {
              await controller.authController.signOut();
            },
            icon: Icon(Icons.exit_to_app, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(27),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Profile Setting',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            height: Get.height / 1.5,
            alignment: Alignment.topCenter,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                27,
                60,
                27,
                0,
              ),
              shrinkWrap: false,
              children: [
                Container(
                  height: 49,
                  margin: const EdgeInsets.symmetric(
                    vertical: 5,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.email,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Text(
                        controller.user.value.email ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                GlobalTextField(
                  controller: controller.nameController,
                  onChanged: (value) {
                    controller.nameValue.value = value;
                  },
                  inputAction: TextInputAction.next,
                  prefixIcon: Icons.person,
                  hintText: 'Please enter your name',
                ),
                GlobalTextField(
                  controller: controller.heightController,
                  onChanged: (value) {
                    controller.heightValue.value = value;
                  },
                  keyboardType: TextInputType.number,
                  inputAction: TextInputAction.done,
                  prefixIcon: Icons.arrow_upward,
                  hintText: 'Please enter your height',
                ),
                Obx(
                  () => GlobalDatePicker(
                    onPickedDate: (date) {
                      controller.selectedPickUpDateTime.value = date;
                    },
                    currentTime: controller.selectedPickUpDateTime.value,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Radio(
                            visualDensity: VisualDensity.compact,
                            value: 'MALE',
                            groupValue: controller.genderValue.value,
                            onChanged: null,
                          ),
                          const SizedBox(
                            width: 0,
                          ),
                          Text(
                            'Male',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            visualDensity: VisualDensity.compact,
                            value: 'FEMALE',
                            groupValue: controller.genderValue.value,
                            onChanged: null,
                          ),
                          const SizedBox(
                            width: 0,
                          ),
                          Text(
                            'Female',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => ElevatedButton(
                    onPressed: controller.updateUserData,
                    child: controller.isSubmitting.value
                        ? const GlobalLoading()
                        : const Text(
                            'Change Data',
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
