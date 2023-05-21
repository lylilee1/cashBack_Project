import 'package:flutter/material.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldskey =
  GlobalKey<ScaffoldMessengerState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScaffoldMessenger(
          key: _scaffoldskey,
          child: const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: Text('Update Profile Screen'),
            ),
          ),
        ),
      ),
    );
  }
}
