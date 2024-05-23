import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDonorAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllDonors() {
    return db.collection("dono-users").snapshots();
  }

  Future<Map<String, dynamic>> currentDonor(String email) async {
    final docRef = db.collection("dono-users").doc(email);
    await docRef.get().then((DocumentSnapshot doc) async {
      return doc.data() as Map<String, dynamic>;
    }, onError: (e) {
      print("Error getting document: $e");
    });
      return {"Empty": "Empty"};
  }
}
