import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  static String routeName = '/dashboard';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: Column(
        children: [
          //search bar
          Container(
            margin: const EdgeInsets.symmetric(vertical: 30.0),
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Colors.grey[200]?.withOpacity(0.8),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: const Row(
              children: [
                Icon(Icons.search),
                SizedBox(width: 10.0),
                Text('Search'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
