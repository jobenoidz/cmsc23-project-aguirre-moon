import '../models/donation.dart';
import '../models/donation_drive.dart';

class DummyData {
  static final List<Donation> dummyDonations = [
    Donation(id: '1', category: 'Food', status: 'Pending'),
    Donation(id: '2', category: 'Clothes', status: 'Confirmed'),
    Donation(id: '3', category: 'Cash', status: 'Scheduled for Pick-up'),
  ];

  static final List<DonationDrive> dummyDonationDrives = [
    DonationDrive(
      id: '1',
      title: 'COVID-19 Relief',
      description: 'Help those affected by the pandemic.',
      photos: ['photo1.jpg', 'photo2.jpg'],
    ),
    DonationDrive(
      id: '2',
      title: 'Winter Clothing Drive',
      description: 'Collect warm clothes for the homeless.',
      photos: ['photo3.jpg', 'photo4.jpg'],
    ),
  ];
}

