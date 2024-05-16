import 'dart:convert';

class Org {
  String name; //may ari ng org
  String email; //email ni user
  List<dynamic> address;
  String contact;
  String orgName;
  String orgProof;
  bool status;

  Org({
    required this.name,
    required this.email,
    required this.address,
    required this.contact,
    required this.orgName,
    required this.orgProof,
    required this.status,
  });

  // Factory constructor to instantiate object from json format
  factory Org.fromJson(Map<String, dynamic> json) {
    return Org(
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

  static List<Org> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Org>((dynamic d) => Org.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Org org) {
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
