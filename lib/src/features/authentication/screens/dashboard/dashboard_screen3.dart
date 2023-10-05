import 'package:cashback/src/common_widgets/app_bar/appBarWidget.dart';
import 'package:flutter/material.dart';

List<String> label = [
  'magasin',
  'commandes',
  'Profile',
  'gestion produits',
  'statistiquess',
];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  static String routeName = '/Supplier_Dashboard';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: 'Dashboard'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: height * 0.015, vertical: height * 0.03),
        child: GridView.count(
          childAspectRatio: 1.0,
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: List.generate(
            6,
                (index) {
              return Container(
                decoration: BoxDecoration(
                  color: const Color(0xff453658),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 50,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      label[index],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
