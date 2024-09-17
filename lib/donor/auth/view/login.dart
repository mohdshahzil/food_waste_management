import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management/donor/donor_home.dart';
import 'package:lottie/lottie.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DonorLogin extends StatefulWidget {
  const DonorLogin({super.key});

  @override
  _DonorLoginState createState() => _DonorLoginState();
}

class _DonorLoginState extends State<DonorLogin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // If the user cancels the login, googleUser will be null
      if (googleUser == null) {
        return null; // User canceled the login
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase using the Google credential
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      // Handle any errors that occur during sign in
      print('Error during Google Sign-In: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text(
              'Donor Login',
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
              "Login to donate food and help those in need  ",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 20),
            Lottie.asset('assets/foodanimation.json'),
            const SizedBox(height: 35),
            OutlinedButton(
              onPressed: () async {
                UserCredential? userCredential = await signInWithGoogle();
                if (userCredential != null) {
                  // User is signed in, get the user's name
                  String? userName = userCredential.user?.displayName;

                  // Navigate to DonorHome screen, passing the user's name
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DonorHome(userName: userName),
                    ),
                  );
                } else {
                  // Sign-in failed or was canceled
                  print("Sign-in failed or canceled");
                }
              },
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
