import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String? id;
  final String? username;
  final dynamic? lat;
  final dynamic? long;
  UserModel({this.id, this.lat, this.long, this.username});
  UserModel.fromMap(Map<String, dynamic> snapshot, this.id)
      : username = snapshot['username'],
        lat = snapshot['lat'],
        long = snapshot['long'];
  toJson() {
    return {"username": username, "lat": lat, "long": long};
  }
}
