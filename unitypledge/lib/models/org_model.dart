/*
  Created by: Claizel Coubeili Cepe
  Date: updated April 26, 2023
  Description: Sample todo app with Firebase 
*/
import 'dart:convert';

class Org {
  String id;
  String orgName;
  String user;
  bool status;

  Org({
    required this.id,
    required this.orgName,
    required this.user,
    required this.status,
  });

  // Factory constructor to instantiate object from json format
  factory Org.fromJson(Map<String, dynamic> json) {
    return Org(
      id: json['id'],
      orgName: json['orgName'],
      user: json['user'],
      status: json['status'],
    );
  }

  static List<Org> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Org>((dynamic d) => Org.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Org org) {
    return {
      'id' : org.id,
      'orgName': org.orgName,
      'user': org.user,
      'status': org.status,
    };
  }
}
