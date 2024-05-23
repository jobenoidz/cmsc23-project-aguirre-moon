import 'package:flutter/material.dart';
import '../models/organization.dart';

class OrganizationTile extends StatelessWidget {
  final Organization organization;

  OrganizationTile({required this.organization});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(organization.name),
      subtitle: Text(organization.about),
    );
  }
}
