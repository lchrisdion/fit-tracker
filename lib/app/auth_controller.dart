import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_tracker/app/repositories/user_repository.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class AuthController extends GetxService {
  final UserRepository userRepository = UserRepository();
  final FirebaseAuth auth = FirebaseAuth.instance;
  late final user = auth.currentUser.obs;
  late StreamSubscription userStreamSubsription =
      FirebaseAuth.instance.authStateChanges().listen((user) {
    if (user?.uid != null) {}
  });
  late final isLogin = user.value?.uid != null.obs;
  @override
  void onInit() {
    super.onInit();
    userStreamSubsription = userStreamSubsription;
    signUp('chrisdionleon80@gmail.com', 'nopassword');
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
      var response = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (response.additionalUserInfo?.isNewUser == true)
        await addUser(
          email: email,
          height: 165,
          isMale: true,
          uid: response.user?.uid ?? "",
          dateOfBirth: Jiffy().valueOf.toString(),
        );
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

  addUser(
      {required String email,
      required int height,
      required bool isMale,
      required String uid,
      required String dateOfBirth}) async {
    try {
      await userRepository.addUserData(
        email: email,
        height: height,
        isMale: isMale,
        uid: uid,
        dateOfBirth: dateOfBirth,
      );
    } catch (e) {}
  }

  addTrackData(
      {required int weight, required String uid, required String date}) async {
    try {
      await userRepository.addUserTrackData(
        date: date,
        weight: weight,
        uid: uid,
      );
    } catch (e) {}
  }
}
