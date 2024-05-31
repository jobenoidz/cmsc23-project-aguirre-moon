import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unitypledge/api/firebase_org_api.dart';
import 'package:unitypledge/models/org_model.dart';

class OrgListProvider with ChangeNotifier {
  FirebaseOrgAPI firebaseService = FirebaseOrgAPI();
  late Stream<QuerySnapshot> _orgStream;
  late Stream<QuerySnapshot> _pendingStream;

  OrgListProvider() {
    fetchOrgs();
    fetchPending();
  }
  // getter
  Stream<QuerySnapshot> get orgs => _orgStream;
  Stream<QuerySnapshot> get pendings => _pendingStream;

  void fetchOrgs() {
    _orgStream = firebaseService.getAllOrgs();
    notifyListeners();
  }

  void fetchPending() {
    _pendingStream = firebaseService.getPending();
    notifyListeners();
  }

  Future<void> approveOrg(Org org) async {
    await firebaseService.approveOrg(org.email, org.toJson(org));
    notifyListeners();
  }
}
