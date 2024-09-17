import 'package:flutter/material.dart';

class DonorHome extends StatelessWidget {
  final String? userName; // Accept the username

  const DonorHome({super.key, this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, $userName'), // Display the user's name
      ),
      body: Center(
        child: const Text('Welcome to Donor Home'),
      ),
    );
  }
}
