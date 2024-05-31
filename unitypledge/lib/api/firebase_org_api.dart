import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseOrgAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> savePendingOrg(String email, Map<String, dynamic> org) async {
    print("API Saving user ---------");
    try {
      await db.collection("org-approval").doc(email).set(org);
    } on FirebaseException catch (e) {
      print("Firebase Exceptin: ${e.code} : ${e.message}");
    } catch (e) {
      print('Error 001: $e');
    }
  }

  Future<void> approveOrg(String email, Map<String, dynamic> org) async {
    try {
      await db.collection("org-users").doc(email).set(org);
      await db.collection("org-approval").doc(email).delete();
    } on FirebaseException catch (e) {
      print("Firebase Exceptin: ${e.code} : ${e.message}");
    } catch (e) {
      print('Error 001: $e');
    }
  }

  Stream<QuerySnapshot> getAllOrgs() {
    return db.collection("org-users").snapshots();
  }

  Stream<QuerySnapshot> getPending() {
    return db.collection("org-approval").snapshots();
  }
}
