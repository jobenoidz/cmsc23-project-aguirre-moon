import 'dart:convert';

class Donation {
  String donorEmail;
  String orgEmail;
  List<dynamic> categories;
  bool isPickUp;
  String weight;
  // String photo;
  String date;
  List<dynamic>? addresses;
  String? contact;

  Donation(
      {
      required this.donorEmail,
      required this.orgEmail,
      required this.categories,
      required this.isPickUp,
      required this.weight,
      required this.date,
      this.addresses,
      this.contact}
      
      );

  // Factory constructor to instantiate object from json format
  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
        donorEmail: json['donorEmail'],
        orgEmail: json['orgEmail'],
        categories: json['categories'],
        isPickUp: json['isPickUp'],
        weight: json['weight'],
        date: json['date'],
        addresses: json['addresses'],
        contact: json['contact']
      );
  }

  static List<Donation> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Donation>((dynamic d) => Donation.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Donation donation) {
    return {
      'donorEmail': donation.donorEmail,
      'orgEmail': donation.orgEmail,
      'categories': donation.categories,
      'isPickUp': donation.isPickUp,
      'weight': donation.weight,
      'date': donation.date,
      'addresses': donation.addresses,
      'contact': donation.contact
    };
  }
}
