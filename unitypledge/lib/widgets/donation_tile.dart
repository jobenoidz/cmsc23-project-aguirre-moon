import 'package:flutter/material.dart';
import '../models/donation.dart';

class DonationTile extends StatelessWidget {
  final Donation donation;
  final Function(String) onUpdateStatus;

  DonationTile({required this.donation, required this.onUpdateStatus});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(donation.category),
      subtitle: Text(donation.status),
      trailing: DropdownButton<String>(
        value: donation.status,
        items: <String>['Pending', 'Confirmed', 'Scheduled for Pick-up', 'Complete', 'Canceled']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          onUpdateStatus(newValue!);
        },
      ),
    );
  }
}
