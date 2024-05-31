import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      return user;
    } catch (e) {
      print('Error signing in: $e');
      return null;
    }
  }

  // Get the current user's UID
  String? getCurrentUserId() {
    User? user = _auth.currentUser;
    return user?.uid;
  }
}
