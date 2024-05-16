import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:unitypledge/api/firebase_auth_api.dart';
import 'package:unitypledge/models/donor_model.dart';
import 'package:unitypledge/models/pending_org_model.dart';

class UserAuthProvider with ChangeNotifier {
  late Stream<User?> _userStream;
  late FirebaseAuthApi authService;
  late Stream<QuerySnapshot> _userDeets;

  UserAuthProvider() {
    authService = FirebaseAuthApi();
    _userStream = authService.fetchUser();
    _userDeets = authService.fetchDeets();
  }

  Stream<User?> get userStream => _userStream;
  User? get user => authService.getUser();
  Stream<QuerySnapshot> get userDeets => _userDeets;

  Future<void> signUp(String email, String password) async {
    await authService.signUp(email, password);
  }

  Future<void> saveDonor(String email, Donor donor) async {
    print("Saving user ---------------");
    await authService.saveDonor(email, donor.toJson(donor));
  }

  Future<void> savePendingOrg(String email, PendingOrg org) async {
    print("Saving user ---------------");
    await authService.savePendingOrg(email, org.toJson(org));
  }

  Future<void> signIn(String email, String password) async {
    try {
      await authService.signIn(email, password);
      print("Success");
    } on FirebaseException catch (e) {
      print("Error: ${e.code} : ${e.message}");
    } catch (e) {
      print("Error: $e");
    }
    print("Sign in called --------");
  }

  Future<void> signOut() async {
    await authService.signOut();
  }
}
