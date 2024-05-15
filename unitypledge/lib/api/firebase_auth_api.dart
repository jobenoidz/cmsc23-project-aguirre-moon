import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthApi {
  late FirebaseAuth auth;
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  FirebaseAuthApi() {
    auth = FirebaseAuth.instance;
  }

  Stream<User?> fetchUser() {
    return auth.authStateChanges();
  }

  Stream<QuerySnapshot> fetchDeets(){
    return db.collection("users").snapshots();
  }

  User? getUser() {
    return auth.currentUser;
  }

  Future<void> signUp(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseException catch (e) {
      print("Firebase Exceptin: ${e.code} : ${e.message}");
    } catch (e) {
      print('Error 001: $e');
    }
  }

  Future<void> saveUser(String email, Map<String, dynamic> deets) async {
    print("API Saving user ---------");
    try {
      await db.collection("users").doc(email).set(deets);
    } on FirebaseException catch (e) {
      print("Firebase Exceptin: ${e.code} : ${e.message}");
    } catch (e) {
      print('Error 001: $e');
    }
  }

  Future<String> signIn(String email, String password) async {
    print("API SIGN IN ==============");
    try {
      UserCredential credentials = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(credentials);
      return "Success";
    } on FirebaseException catch (e) {
      return "Firebase Exceptin: ${e.code} : ${e.message}";
    } catch (e) {
      return 'Error 001: $e';
    }
  }

  Future<void> signOut() async {
    auth.signOut();
  }
}
