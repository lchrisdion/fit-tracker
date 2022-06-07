import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../ui/widgets/global_date_picker.dart';
import '../../../ui/widgets/global_loading.dart';
import '../../../ui/widgets/global_textfield.dart';
import '../controllers/profile_register_controller.dart';

class ProfileRegisterView extends GetView<ProfileRegisterController> {
  const ProfileRegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(27),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Profile Register',
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
              children: [
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
                      controller.datePicked.value = true;
                    },
                    currentTime: controller.selectedPickUpDateTime.value,
                    description: controller.datePicked.value
                        ? null
                        : 'Please pick your date of birth',
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
                            onChanged: (String? value) {
                              controller.genderValue.value = value ?? "MALE";
                            },
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
                            onChanged: (String? value) {
                              controller.genderValue.value = value ?? "MALE";
                            },
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
                    onPressed: controller.addUser,
                    child: controller.isSubmitting.value
                        ? const GlobalLoading()
                        : const Text(
                            'Add Data',
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
