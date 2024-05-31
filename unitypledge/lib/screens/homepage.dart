import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitypledge/providers/auth_provider.dart';
import 'package:unitypledge/screens/admin/a_homepage.dart';
import 'package:unitypledge/screens/donor/d_donorpage.dart';
import 'package:unitypledge/screens/org/o_pending.dart';
import 'package:unitypledge/screens/signin.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Stream<User?> userStream = context.watch<UserAuthProvider>().userStream;

    return StreamBuilder(
        stream: userStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("Error encountered! ${snapshot.error}"),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (!snapshot.hasData) {
            return const SignInPage();
          }

          // if user is logged in
          User? user = snapshot.data;
          if (user != null) {
            return FutureBuilder<String>(
              future:
                  context.read<UserAuthProvider>().checkAccount(user.email!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error encountered! ${snapshot.error}"),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const SignInPage();
                }

                // Get the account
                String accType = snapshot.data!;

                switch (accType) {
                  case "isAdmin":
                    return AdminPage();
                  case "isOrg":
                    return const OrgPendingPage();
                  case "isPending":
                    return const OrgPendingPage();
                  case "isDonor":
                  default:
                    return const DonorPage();
                }
              },
            );
          } else {
            return const SignInPage();
          }
        });
  }
}
