import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitypledge/models/org_model.dart';
import 'package:unitypledge/providers/org_provider.dart';

class OrganizationList extends StatefulWidget {
  const OrganizationList({super.key});

  @override
  State<OrganizationList> createState() => _OrganizationListState();
}

class _OrganizationListState extends State<OrganizationList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Organization List (Admin)'),
        ),
        body: orgLists(context));
  }

  Widget orgLists(BuildContext context) {
    return Center(
        child: Column(children: [
      const Text("Organizations for Approval"),
      pendingList(context),
      const Divider(),
      orgList(context)
    ]));
  }

  Widget pendingList(BuildContext context) {
    Stream<QuerySnapshot> pendingStream =
        context.watch<OrgListProvider>().pendings;

    return StreamBuilder(
      stream: pendingStream,
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

        return Expanded(
          child: ListView.builder(
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
                      Expanded(
                          child: Text(
                        org.orgName,
                        textAlign: TextAlign.left,
                      )),
                      ElevatedButton(
                          onPressed: () {
                            //TODO check org details and donations received
                          },
                          child: const Icon(Icons.remove_red_eye)),
                      ElevatedButton(
                          //approve org
                          onPressed: () async {
                            await context.read<OrgListProvider>().approveOrg(org);
                          },
                          child: const Icon(Icons.thumb_up)),
                    ],
                  ));
            }),
          ),
        );
      },
    );
  }

  Widget orgList(BuildContext context) {
    Stream<QuerySnapshot> orgStream = context.watch<OrgListProvider>().orgs;

    return StreamBuilder(
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

        return Expanded(
          child: ListView.builder(
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
                      Expanded(
                          child: Text(
                        org.orgName,
                        textAlign: TextAlign.left,
                      )),
                      ElevatedButton(
                          //donate to org
                          onPressed: () {
                            //TODO check org details and donations received
                          },
                          child: const Icon(Icons.remove_red_eye))
                    ],
                  ));
            }),
          ),
        );
      },
    );
  }
}
