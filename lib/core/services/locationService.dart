import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tracker/core/models/user.dart';
import 'package:tracker/core/viewmodels/userviewmodel.dart';

class LocationService {
  final UserViewModel _userViewModel = UserViewModel();
  User user = FirebaseAuth.instance.currentUser!;
  Future<Position> getLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  getLocationStream() {
    FirebaseFirestore database = FirebaseFirestore.instance;
    late CollectionReference ref;
    ref = database.collection('users');
    return Geolocator.getPositionStream().listen((position) {
      ref
          .doc(user.uid)
          .update({"lat": position.latitude, "long": position.longitude});
    });
  }
}
