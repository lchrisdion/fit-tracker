import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_tracker/app/data/model/user_data_model.dart';
import 'package:fit_tracker/app/data/model/user_track_model.dart';

import '../ui/helpers/ui_helper.dart';

class UserRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference usersCollection = firestore.collection("users");

  addUserData(
      {required String email,
      required String name,
      required int height,
      required bool isMale,
      required String uid,
      required String dateOfBirth}) async {
    try {
      var data = {
        "email": email,
        "height": height,
        "is_male": isMale,
        "uid": uid,
        "date_of_birth": dateOfBirth,
        "name": name,
      };
      print(data);
      await usersCollection.doc(uid).set(data);
    } on FirebaseException catch (e) {
      UIHelper.errorFlushbar(message: e.toString());
      print(e.toString());
    }
  }

  addUserTrackData(
      {required int weight, required String uid, required String date}) async {
    try {
      await usersCollection.doc(uid).collection('user-tracks').doc(date).set(
        {
          "date_time": date,
          "weight": weight,
        },
      );
    } on FirebaseException catch (e) {
      UIHelper.errorFlushbar(message: e.toString());
      print(e.toString());
    }
  }

  Future<UserData> getUserData({
    required String uid,
  }) async {
    try {
      var response = await usersCollection.doc(uid).get();
      return UserData.fromDocumentSnapshot(response);
    } on FirebaseException catch (e) {
      UIHelper.errorFlushbar(message: e.toString());
      throw e;
    }
  }

  Stream<List<UserTrack>> streamTrackData({
    required String uid,
  }) {
    return usersCollection
        .doc(uid)
        .collection('user-tracks')
        .orderBy("date_time", descending: true)
        .snapshots()
        .map(
      (QuerySnapshot query) {
        return query.docs.map((value) {
          return UserTrack.fromDocumentSnapshot(value);
        }).toList();
      },
    );
  }

  Future<List<UserTrack>> getUserTrackData({
    required String uid,
  }) async {
    try {
      var response = await usersCollection
          .doc(uid)
          .collection('user-tracks')
          .orderBy("date_time", descending: true)
          .get();
      return response.docs.map((value) {
        return UserTrack.fromDocumentSnapshot(value);
      }).toList();
    } on FirebaseException catch (e) {
      UIHelper.errorFlushbar(message: e.toString());
      throw e;
    }
  }
}
