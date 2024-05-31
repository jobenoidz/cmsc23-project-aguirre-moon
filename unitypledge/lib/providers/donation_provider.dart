import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unitypledge/api/firebase_donation_api.dart';
import 'package:unitypledge/models/donation_model.dart';

class DonationProvider with ChangeNotifier {
  FirebaseDonationAPI donationService = FirebaseDonationAPI();
  late Stream<QuerySnapshot> _donationStream;

  DonationProvider() {
    fetchDonations();
  }

  // getter
  Stream<QuerySnapshot> get donations => _donationStream;

  void fetchDonations() {
    _donationStream = donationService.getAllDonations();
    notifyListeners();
  }

  Future<void> addDonation(Donation donation) async {
    await donationService.addDonation(donation.toJson(donation));
  }


}
