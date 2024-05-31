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

  Stream<QuerySnapshot> fetchDeets() {
    return db.collection("users").snapshots();
  }

  User? getUser() {
    return auth.currentUser;
  }

  String? getEmail() {
    return auth.currentUser?.email;
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

  Future<String> checkAccount(String email) async {
    try {
      DocumentSnapshot isAdmin =
          await db.collection("admin-users").doc(email).get();

      if (isAdmin.exists) {
        return "isAdmin";
      }

      DocumentSnapshot isPending =
          await db.collection("org-approval").doc(email).get();

      if (isPending.exists) {
        return "isPending";
      }

      DocumentSnapshot isOrg =
          await db.collection("org-users").doc(email).get();

      if (isOrg.exists) {
        return "isOrg";
      }

      DocumentSnapshot isDonor =
          await db.collection("dono-users").doc(email).get();

      if (isDonor.exists) {
        return "isDonor";
      }

      return "";
    } on FirebaseException catch (e) {
      print("Firebase Exception: ${e.code} : ${e.message}");
      return "";
    } catch (e) {
      print('Error 001: $e');
      return "";
    }
  }

  Future<void> saveDonor(String email, Map<String, dynamic> donor) async {
    print("API Saving Donor ---------");
    try {
      DocumentSnapshot docSnapshot =
          await db.collection("dono-users").doc(email).get();

      if (!docSnapshot.exists) {
        print("User added to dono-users");
        await db.collection("dono-users").doc(email).set(donor);
      } else {
        print("User already exists.");
      }
    } on FirebaseException catch (e) {
      print("Firebase Exception: ${e.code} : ${e.message}");
    } catch (e) {
      print('Error 001: $e');
    }
  }

  Future<void> savePendingOrg(String email, Map<String, dynamic> org) async {
    print("API Saving Org ---------");
    try {
      await db.collection("org-approval").doc(email).set(org);
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
