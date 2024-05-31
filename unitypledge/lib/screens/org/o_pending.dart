import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitypledge/providers/auth_provider.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Your organization is pending approval. Check again later"),
        ElevatedButton(
            onPressed: () {
              context.read<UserAuthProvider>().signOut();
              Navigator.pop(context);
            },
            child: Text("Logout"))
      ],
    );
  }
}
