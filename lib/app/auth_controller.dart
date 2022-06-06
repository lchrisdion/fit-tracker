import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_tracker/app/data/model/user_data_model.dart';
import 'package:fit_tracker/app/repositories/user_repository.dart';
import 'package:fit_tracker/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxService {
  final UserRepository userRepository = UserRepository();
  final FirebaseAuth auth = FirebaseAuth.instance;
  late final firebaseUserData = auth.currentUser.obs;

  final userData = UserData().obs;
  late StreamSubscription userStreamSubsription =
      FirebaseAuth.instance.authStateChanges().listen((user) async {
    if (user?.uid != null) {
      isLogin.value = true;
      firebaseUserData.value = user;
      await getUserData();
    } else {
      isLogin.value = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAllNamed(Routes.LOGIN);
      });
    }
  });
  final isLogin = false.obs;
  final userHasData = false.obs;

  @override
  void onInit() {
    super.onInit();
    userStreamSubsription = userStreamSubsription;
  }

  @override
  void onClose() {
    super.onClose();
    userStreamSubsription.cancel();
  }

  Future<void> signUp(
    String email,
    String password,
  ) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        await signIn(email, password);
      } else
        print(e.toString());
    }
  }

  Future<void> signIn(
    String email,
    String password,
  ) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
      userData.value = UserData();
      userHasData.value = false;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  getUserData() async {
    try {
      var response = await userRepository.getUserData(
          uid: firebaseUserData.value?.uid ?? "");
      userData.value = response;
      userHasData.value = true;
    } catch (e) {
    } finally {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          if (userData.value.uid == null)
            Get.offAllNamed(
              Routes.PROFILE_DATA,
              arguments: {
                'email': firebaseUserData.value?.email,
                'uid': firebaseUserData.value?.uid,
              },
            );
          else if (Get.currentRoute != Routes.HOME)
            Get.offAllNamed(Routes.HOME);
        },
      );
    }
  }
}
