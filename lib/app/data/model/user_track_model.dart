import 'package:cloud_firestore/cloud_firestore.dart';

class UserTrack {
  int? weight;
  String? date;

  UserTrack({this.weight, this.date});

  UserTrack.fromJson(Map<String, dynamic> json) {
    weight = json['weight'];
    date = json['date_time'];
  }
  UserTrack.fromDocumentSnapshot(DocumentSnapshot data) {
    weight = data['weight'];
    date = data['date_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['weight'] = this.weight;
    data['date_time'] = this.weight;
    return data;
  }
}
