import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CollectorLogin extends StatelessWidget {
  const CollectorLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text(
              'Collector',
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Welcome to ShareFood',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 20),
            const Text(
              "Collect food at your ease  ",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 20),
            Lottie.asset('assets/foodanimation.json'),
            const SizedBox(height: 35),
            OutlinedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                foregroundColor: MaterialStateProperty.all(Colors.black),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )),
              ),
              child: const Text('Continue with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
