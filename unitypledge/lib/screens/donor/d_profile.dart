import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitypledge/models/donor_model.dart';
import 'package:unitypledge/providers/auth_provider.dart';

class DonorDetailsPage extends StatelessWidget {
  final Donor donorDetails;

  const DonorDetailsPage({super.key, required this.donorDetails});

  @override
  Widget build(BuildContext context) {
    Stream<User?> userStream = context.watch<UserAuthProvider>().userStream;

    return Scaffold(
      appBar: AppBar(title: Text("")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(18),
              child: summaryBuilder(donorDetails),
            ),
          ],
        ),
      ),
    );
  }

  Widget summaryBuilder(Donor donorData) {
    //function for adding each item to summary

    return Column(
      children: [
        const Text(
          "Summary",
          style: TextStyle(fontSize: 27),
        ),
        Column(
          children: donorData.toJson(donorData).entries.map((entry) {
            //maps each item from the formData map
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
                      entry.value,
                      style: const TextStyle(
                          fontSize: 17, fontStyle: FontStyle.italic),
                    ),
                  )
                ],
              ),
            );
          }).toList(), //saves mapped item to be added to list widget
        ),
      ],
    );
  }
}
