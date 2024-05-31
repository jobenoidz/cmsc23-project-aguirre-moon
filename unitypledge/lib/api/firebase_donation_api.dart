import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDonationAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllDonations() {
    return db.collection("donations").snapshots();
  }

  Future<void> addDonation(Map<String, dynamic> donation) async {
    print("API Saving Donation---------");
    try {
      await db.collection("donations").add(donation);
} on FirebaseException catch (e) {
      print("Firebase Exception: ${e.code} : ${e.message}");
    } catch (e) {
      print('Error 001: $e');
    }
  }

  // Future<Map<String, dynamic>> currentDonor(String email) async {
  //   final docRef = db.collection("dono-users").doc(email);
  //   try {
  //     DocumentSnapshot doc = await docRef.get();
  //     if (doc.exists) {
  //       return doc.data() as Map<String, dynamic>;
  //     } else {
  //       return {"Error": "Document does not exist"};
  //     }
  //   } catch (e) {
  //     print("Error getting document: $e");
  //     return {"Error": e.toString()};
  //   }
  // }
}
