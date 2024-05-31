import 'package:flutter/material.dart';

class DonorDetailsPage extends StatelessWidget {
  final Map<String, dynamic> donorDetails;

  const DonorDetailsPage({super.key, required this.donorDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Donor Profile")),
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
          children: donorDetails.entries.map((entry) {
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
                      entry.value.toString(),
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