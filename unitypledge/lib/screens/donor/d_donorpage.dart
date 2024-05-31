import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitypledge/models/org_model.dart';
import 'package:unitypledge/providers/org_provider.dart';
import 'package:unitypledge/screens/donor/d_donationform.dart';
import 'package:unitypledge/screens/widgets/drawer.dart';

class DonorPage extends StatefulWidget {
  const DonorPage({super.key});

  @override
  State<DonorPage> createState() => _DonorPageState();
}

class _DonorPageState extends State<DonorPage> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> orgStream = context.watch<OrgListProvider>().orgs;
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: const Text("ORGS"),
      ),
      body: StreamBuilder(
        stream: orgStream,
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
              Org org = Org.fromJson(
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
                    Expanded(child: Text(
                      org.orgName,
                      textAlign: TextAlign.left,
                    )),
                    ElevatedButton(
                      //donate to org
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DonationForm(organization: org.orgName),
                            ));
                      },
                      child: const Icon(Icons.remove_red_eye))
                ],)
              );
            }),
          );
        },
      ),
    );
  }

  //  Drawer get drawer => Drawer(
  //         child: ListView(padding: EdgeInsets.zero, children: [
  //       const DrawerHeader(child: Text("Organizations")),
  //       ListTile(
  //         title: const Text('Details'),
  //         onTap: () {
  //           Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                   builder: (context) => const UserDetailsPage()));
  //         },
  //       ),
  //       ListTile(
  //         title: const Text('Todo List'),
  //         onTap: () {
  //           Navigator.pop(context);
  //           Navigator.pushNamed(context, "/");
  //         },
  //       ),
  //       ListTile(
  //         title: const Text('Logout'),
  //         onTap: () {
  //           context.read<UserAuthProvider>().signOut();
  //           Navigator.pop(context);
  //         },
  //       ),
  //     ]));
}
