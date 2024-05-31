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

  Stream<QuerySnapshot> getDonorDonations(String donorEmail) {
    return db.collection("donations")
        .where('donorEmail', isEqualTo: donorEmail)
        .snapshots();
  }

  Stream<QuerySnapshot> getOrgDonors(String donorEmail) {
    return db.collection("donations")
        .where('donorEmail', isEqualTo: donorEmail)
        .snapshots();
  }

}
