import 'dart:convert';

class PendingOrg {
  String name; //may ari ng org
  String email; //email ni user
  List<dynamic> address;
  String contact;
  String orgName;
  String orgProof;
  bool status;

  PendingOrg({
    required this.name,
    required this.email,
    required this.address,
    required this.contact,
    required this.orgName,
    required this.orgProof,
    required this.status,
  });

  // Factory constructor to instantiate object from json format
  factory PendingOrg.fromJson(Map<String, dynamic> json) {
    return PendingOrg(
      name: json['name'],
      email: json['email'],
      address: json['address'],
      contact: json['contact'],
      orgName: json['orgName'],
      orgProof: json['orgProof'],
      status: json['status'],
      // orgProof: json['orgProof'],
    );
  }

  static List<PendingOrg> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<PendingOrg>((dynamic d) => PendingOrg.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(PendingOrg org) {
    return {
      'name': org.name,
      'email': org.email,
      'address': org.address,
      'contact': org.contact,
      'orgName': org.orgName,
      'orgProof':org.orgProof,
      'status': org.status,
      // 'orgProof': org.orgProof
    };
  }
}
