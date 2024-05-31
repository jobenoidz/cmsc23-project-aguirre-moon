import 'package:flutter/material.dart';
import '../widgets/donation_tile.dart';
import '../models/donation.dart';
import '../services/donation_service.dart';

class OrganizationHomeScreen extends StatefulWidget {
  @override
  _OrganizationHomeScreenState createState() => _OrganizationHomeScreenState();
}

class _OrganizationHomeScreenState extends State<OrganizationHomeScreen> {
  final DonationService _donationService = DonationService();
  late List<Donation> _donations;

  @override
  void initState() {
    super.initState();
    _donations = _donationService.getDonations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Organization Home')),
      body: ListView.builder(
        itemCount: _donations.length,
        itemBuilder: (context, index) {
          return DonationTile(
            donation: _donations[index],
            onUpdateStatus: (status) {
              _donationService.updateDonationStatus(_donations[index].id, status);
              setState(() {
                _donations[index].status = status;
              });
            },
          );
        },
      ),
    );
  }
}
