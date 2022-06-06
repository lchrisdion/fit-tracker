import 'package:firebase_core/firebase_core.dart';
import 'package:fit_tracker/app/auth_controller.dart';
import 'package:fit_tracker/app/modules/home/bindings/home_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: HomeBinding(),
      initialRoute: Routes.HOME,
      // theme: appThemeData,
      getPages: AppPages.routes,
      navigatorKey: Get.key,
    );
  }
}
