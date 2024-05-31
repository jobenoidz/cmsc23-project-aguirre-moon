import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitypledge/models/donation_model.dart';
import 'package:unitypledge/models/org_model.dart';
import 'package:unitypledge/providers/auth_provider.dart';
import 'package:unitypledge/providers/donation_provider.dart';
import 'package:unitypledge/providers/org_provider.dart';
import 'package:unitypledge/screens/donor/d_donationform.dart';
import 'package:unitypledge/screens/org/o_donationdetails.dart';
import 'package:unitypledge/screens/widgets/drawer.dart';

class OrgPage extends StatefulWidget {
  final Map<String, dynamic> orgDetails;

  const OrgPage({super.key, required this.orgDetails});

  @override
  State<OrgPage> createState() => _OrgPageState();
}

class _OrgPageState extends State<OrgPage> {
  @override
  Widget build(BuildContext context) {
    String orgEmail = context.watch<UserAuthProvider>().getEmail()!;
    Stream<QuerySnapshot> orgDonationStream =
        context.watch<DonationProvider>().getOrgDonors(orgEmail);
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: const Text("ORGS"),
      ),
      body: StreamBuilder(
        stream: orgDonationStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error encountered! ${snapshot.error}"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text("No Donations Found"),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: ((context, index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              Donation donation = Donation.fromJson(
                  document.data() as Map<String, dynamic>);
              return Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(12)),
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        document.id,
                        textAlign: TextAlign.left,
                      )),
                      ElevatedButton(
                          //donate to org
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DonationDetailsPage(
                                        donationDetails: donation.toJson(donation)),
                                ));
                          },
                          child: const Icon(Icons.remove_red_eye))
                    ],
                  ));
            }),
          );
        },
      ),
    );
  }

  
}
