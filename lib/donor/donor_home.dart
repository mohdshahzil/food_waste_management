import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DonorHome extends StatefulWidget {
  final String? userName;

  const DonorHome({super.key, this.userName});

  @override
  State<DonorHome> createState() => _DonorHomeState();
}

class _DonorHomeState extends State<DonorHome> {
  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController(); // New controller

  // Firestore reference
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to submit the form
  Future<void> _submitForm() async {
    final User? user = _auth.currentUser; // Get the current user

    if (user != null) {
      // Collect data to send to Firestore
      Map<String, dynamic> foodDetails = {
        'foodName': _foodNameController.text,
        'quantity': _quantityController.text,
        'address': _addressController.text,
        'description': _descriptionController.text,
        'phoneNumber': _phoneNumberController.text, // Include phone number
        'submittedAt': Timestamp.now(),
      };

      // Save data under 'donors' collection with user's UID
      await _firestore
          .collection('donors')
          .doc(user.uid)
          .set({'donorName': widget.userName});

      await _firestore
          .collection('donors')
          .doc(user.uid)
          .collection('foodDetails')
          .add(foodDetails);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Details submitted successfully!')),
      );

      // Clear fields after submission
      _foodNameController.clear();
      _quantityController.clear();
      _addressController.clear();
      _descriptionController.clear();
      _phoneNumberController.clear(); // Clear phone number field
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${widget.userName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _foodNameController,
              decoration: const InputDecoration(labelText: 'Food Name'),
            ),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(labelText: 'Quantity (Servings)'),
            ),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Submit Details'),
            ),
          ],
        ),
      ),
    );
  }
}
