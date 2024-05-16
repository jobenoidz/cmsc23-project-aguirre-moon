import 'dart:convert';

class Donor {
  String name;
  String email; //kukunin from firebase auth
  List<dynamic> address;
  String contact;

  Donor({
    required this.name,
    required this.email,
    required this.address,
    required this.contact,
  });

  // Factory constructor to instantiate object from json format
  factory Donor.fromJson(Map<String, dynamic> json) {
    return Donor(
      name: json['name'],
      email: json['email'],
      address: json['address'],
      contact: json['contact'],
    );
  }

  static List<Donor> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Donor>((dynamic d) => Donor.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Donor org) {
    return {
      'name': org.name,
      'email': org.email,
      'address': org.address,
      'contact': org.contact,
    };
  }
}
