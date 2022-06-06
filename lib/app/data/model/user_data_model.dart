import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String? dateOfBirth;
  String? email;
  int? height;
  bool? isMale;
  String? uid;
  String? name;

  UserData({
    this.dateOfBirth,
    this.email,
    this.height,
    this.isMale,
    this.uid,
    this.name,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    dateOfBirth = json['date_of_birth'];
    email = json['email'];
    isMale = json['is_male'];
    uid = json['uid'];
    name = json['name'];
  }
  UserData.fromDocumentSnapshot(DocumentSnapshot data) {
    height = data['height'];
    dateOfBirth = data['date_of_birth'];
    email = data['email'];
    isMale = data['is_male'];
    uid = data['uid'];
    name = data['name'];
  }
}
