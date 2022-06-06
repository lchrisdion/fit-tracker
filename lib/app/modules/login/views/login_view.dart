import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../ui/widgets/global_loading.dart';
import '../../../ui/widgets/global_textfield.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
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
                  'Login Register',
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
              shrinkWrap: true,
              children: [
                GlobalTextField(
                  controller: controller.emailController,
                  onChanged: (value) {
                    controller.emailValue.value = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  inputAction: TextInputAction.next,
                  prefixIcon: Icons.email,
                  hintText: 'Please enter your email',
                ),
                GlobalTextField(
                  controller: controller.passwordController,
                  onChanged: (value) {
                    controller.passwordValue.value = value;
                  },
                  inputAction: TextInputAction.done,
                  prefixIcon: Icons.password,
                  isPassword: true,
                  hintText: 'Please enter your password',
                  onSubmit: (value) {
                    controller.passwordValue.value = value;
                    controller.loginUser();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => ElevatedButton(
                    onPressed: controller.loginUser,
                    child: controller.isSubmitting.value
                        ? const GlobalLoading()
                        : Text(
                            'Log In or Register',
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
