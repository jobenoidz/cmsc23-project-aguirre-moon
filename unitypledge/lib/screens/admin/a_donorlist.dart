import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitypledge/models/donor_model.dart';
import 'package:unitypledge/models/org_model.dart';
import 'package:unitypledge/providers/donor_provider.dart';
import 'package:unitypledge/providers/org_provider.dart';
import 'package:unitypledge/screens/donor/d_donationform.dart';
import 'package:unitypledge/screens/donor/d_profile.dart';
import 'package:unitypledge/screens/widgets/drawer.dart';

class DonorList extends StatefulWidget {
  const DonorList({super.key});

  @override
  State<DonorList> createState() => _DonorListState();
}

class _DonorListState extends State<DonorList> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> donorStream = context.watch<DonorListProvider>().donors;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donor List"),
      ),
      body: StreamBuilder(
        stream: donorStream,
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
              child: Text("No Todos Found"),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: ((context, index) {
              Donor donor = Donor.fromJson(
                  snapshot.data?.docs[index].data() as Map<String, dynamic>);
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
                        donor.name,
                        textAlign: TextAlign.left,
                      )),
                      ElevatedButton(
                          //view donor
                          onPressed: () async {

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DonorDetailsPage(donorDetails: donor.toJson(donor))
                                )
                                );
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
