import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CollectorHome extends StatelessWidget {
  const CollectorHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Collector Home',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('donors').snapshots(),
        builder: (context, donorSnapshot) {
          if (donorSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (donorSnapshot.hasError) {
            return Center(child: Text('Error: ${donorSnapshot.error}'));
          }

          if (!donorSnapshot.hasData || donorSnapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No donor details available.'));
          }

          final donors = donorSnapshot.data!.docs;

          return ListView.builder(
            itemCount: donors.length,
            itemBuilder: (context, donorIndex) {
              final donor = donors[donorIndex].data() as Map<String, dynamic>;
              final donorId = donors[donorIndex].id; // UID of the donor

              return FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('donors')
                    .doc(donorId)
                    .collection('foodDetails')
                    .get(),
                builder: (context, foodDetailsSnapshot) {
                  if (foodDetailsSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (foodDetailsSnapshot.hasError) {
                    return Center(
                        child: Text('Error: ${foodDetailsSnapshot.error}'));
                  }

                  if (!foodDetailsSnapshot.hasData ||
                      foodDetailsSnapshot.data!.docs.isEmpty) {
                    return const ListTile(
                      title: Text('No food details available for this donor.'),
                    );
                  }

                  final foodDetails = foodDetailsSnapshot.data!.docs;

                  return Card(
                    margin: const EdgeInsets.all(12.0),
                    color: Colors.white.withOpacity(1),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Donor: ${donor['donorName'] ?? 'Unknown'}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(height: 8),
                          ...foodDetails.map((foodDetail) {
                            final foodDetailData =
                                foodDetail.data() as Map<String, dynamic>;
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Food Name: ${foodDetailData['foodName'] ?? 'N/A'}'),
                                  Text(
                                      'Quantity: ${foodDetailData['quantity'] ?? 'N/A'}'),
                                  Text(
                                      'Address: ${foodDetailData['address'] ?? 'N/A'}'),
                                  Text(
                                      'Description: ${foodDetailData['description'] ?? 'N/A'}'),
                                  Text(
                                      'Phone Number: ${foodDetailData['phoneNumber'] ?? 'N/A'}'),
                                  const SizedBox(height: 8),
                                  const Divider(),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
