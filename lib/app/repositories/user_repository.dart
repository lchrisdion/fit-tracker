import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference usersCollection = firestore.collection("users");

  addUserData(
      {required String email,
      required int height,
      required bool isMale,
      required String uid,
      required String dateOfBirth}) async {
    try {
      await usersCollection.doc(uid).set(
        {
          "email": email,
          "height": height,
          "is-male": isMale,
          "uid": uid,
          "date-of-birth": dateOfBirth,
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  addUserTrackData(
      {required int weight, required String uid, required String date}) async {
    try {
      await usersCollection.doc(uid).collection('user-tracks').doc(date).set(
        {
          "date-time": date,
          "weight": weight,
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
