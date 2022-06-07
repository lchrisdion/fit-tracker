import 'package:get/get.dart';

import '../controllers/profile_register_controller.dart';

class ProfileRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileRegisterController>(
      () => ProfileRegisterController(),
    );
  }
}
