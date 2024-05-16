import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unitypledge/api/firebase_org_api.dart';
import 'package:unitypledge/models/org_model.dart';

class OrgListProvider with ChangeNotifier {
  FirebaseOrgAPI firebaseService = FirebaseOrgAPI();
  late Stream<QuerySnapshot> _todosStream;

  OrgListProvider() {
    fetchOrgs();
  }
  // getter
  Stream<QuerySnapshot> get todo => _todosStream;

  void fetchOrgs() {
    _todosStream = firebaseService.getAllOrgs();
    notifyListeners();
  }

  // void addOrg(Org org) async {
  //   String message = await firebaseService.addOrg(org.toJson(org));
  //   print(message);
  //   notifyListeners();
  // }

  // void editTodo(String id, String newTitle) async {
  //   await firebaseService.editTodo(id, newTitle);
  //   notifyListeners();
  // }

  // void deleteTodo(String id) async {
  //   await firebaseService.deleteTodo(id);
  //   notifyListeners();
  // }

  // void toggleStatus(String id, bool status) async {
  //   await firebaseService.toggleStatus(id, status);
  //   notifyListeners();
  // }
}
