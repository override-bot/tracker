import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  Future<User?> register(username, password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: '$username@email.com', password: password);
    User user = userCredential.user!;
    user.reload();
    return user;
  }

  Future signin(username, password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: '$username@email.com', password: password);
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }
}
