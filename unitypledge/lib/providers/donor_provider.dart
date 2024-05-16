import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unitypledge/api/firebase_donor_api.dart';
import 'package:unitypledge/models/donor_model.dart';

class DonorListProvider with ChangeNotifier {
  FirebaseDonorAPI firebaseService = FirebaseDonorAPI();
  late Stream<QuerySnapshot> _donorsStream;

  OrgListProvider() {
    fetchDonors();
  }
  // getter
  Stream<QuerySnapshot> get todo => _donorsStream;

  void fetchDonors() {
    _donorsStream = firebaseService.getAllDonors();
    notifyListeners();
  }
}
