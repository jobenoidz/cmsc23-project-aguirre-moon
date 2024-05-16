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

  Stream<QuerySnapshot> getAllOrgs() {
    return db.collection("org-users").snapshots();
  }

  // Future<String> deleteTodoteO(String id) async {
  //   try {
  //     await db.collection("org-users").doc(id).delete();

  //     return "Successfully deleted!";
  //   } on FirebaseException catch (e) {
  //     return "Error in ${e.code}: ${e.message}";
  //   }
  // }

  // Future<String> editTodo(String id, String title) async {
  //   try {
  //     await db.collection("orgs").doc(id).update({"title": title});

  //     return "Successfully edited!";
  //   } on FirebaseException catch (e) {
  //     return "Error in ${e.code}: ${e.message}";
  //   }
  // }

  // Future<String> toggleStatus(String id, bool value) async {
  //   try {
  //     await db.collection("orgs").doc(id).update({"completed": value});

  //     return "Successfully toggled!";
  //   } on FirebaseException catch (e) {
  //     return "Error in ${e.code}: ${e.message}";
  //   }
  // }
}
