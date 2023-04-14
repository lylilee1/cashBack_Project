import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../main/main_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  static String routeName = '/onboarding';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to RefurbShop'),
      ),
      body: ScaffoldMessenger(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to RefurbShop!',
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
                      // Navigate to the home screen after successful sign-in
                      Navigator.pushReplacementNamed(context, MainScreen.routeName);
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
                child: const Text('Get Started'),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Sign in to access additional features',
                style: TextStyle(fontSize: 16.0),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the sign-in page
                  Navigator.pushNamed(context, '/signin');
                },
                child: const Text('Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}