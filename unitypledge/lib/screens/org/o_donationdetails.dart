import 'package:flutter/material.dart';

class DonationDetailsPage extends StatelessWidget {
  final Map<String, dynamic> donationDetails;

  const DonationDetailsPage({super.key, required this.donationDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Donation Details")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(18),
              child: summaryBuilder(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget summaryBuilder(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Summary",
          style: TextStyle(fontSize: 27),
        ),
        Column(
          children: donationDetails.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${entry.key}:',
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      entry.value?.toString() ?? "N/A",
                      style: const TextStyle(
                          fontSize: 17, fontStyle: FontStyle.italic),
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}