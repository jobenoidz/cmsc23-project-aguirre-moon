import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseOrgAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addTodo(Map<String, dynamic> org) async {
    try {
      await db.collection("org-users").add(org);

      return "Successfully added!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Stream<QuerySnapshot> getAllTodos() {
    return db.collection("org-users").snapshots();
  }

  Future<String> deleteTodo(String id) async {
    try {
      await db.collection("org-users").doc(id).delete();

      return "Successfully deleted!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

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
