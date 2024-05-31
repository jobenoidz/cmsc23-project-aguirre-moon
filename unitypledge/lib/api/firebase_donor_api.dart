import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDonorAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllDonors() {
    return db.collection("dono-users").snapshots();
  }

  Future<Map<String, dynamic>> currentDonor(String email) async {
  final docRef = db.collection("dono-users").doc(email);
  try {
    DocumentSnapshot doc = await docRef.get();
    if (doc.exists) {
      return doc.data() as Map<String, dynamic>;
    } else {
      return {"Error": "Document does not exist"};
    }
  } catch (e) {
    print("Error getting document: $e");
    return {"Error": e.toString()};
  }
}
}
