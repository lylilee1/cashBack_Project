import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OnboardingPage extends StatefulWidget {
  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  CollectionReference anonymous =
  FirebaseFirestore.instance.collection('anonymous');
  late String _uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to My E-commerce App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to My E-commerce App!',
              style: TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Sign in anonymously with Firebase
                try {
                  UserCredential userCredential =
                  await FirebaseAuth.instance.signInAnonymously();
                  User? user = userCredential.user;
                  if (user != null) {
                    // Check if the user has a linked account
                    if (user.linkedProviderIds.contains('google.com')) {
                      // Navigate to the home screen after successful sign-in
                      Navigator.pushReplacementNamed(context, '/home');
                    } else {
                      // Navigate to the account linking page
                      Navigator.pushNamed(context, '/linkaccount');
                    }
                  }
                } catch (e) {
                  print('Error signing in anonymously: $e');
                  // Show error message to the user
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Error signing in anonymously.'),
                    ),
                  );
                }
              },
              child: Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
