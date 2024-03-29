import 'package:cashback/src/common_widgets/Alert/alert_dialog.dart';
import 'package:cashback/src/common_widgets/app_bar/appBarWidget.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/screens/cart/cart_screen.dart';
import 'package:cashback/src/features/authentication/screens/customer/customer_orders.dart';
import 'package:cashback/src/features/authentication/screens/main/main_screen2.dart';
import 'package:cashback/src/features/authentication/screens/search/search_screen.dart';
import 'package:cashback/src/features/authentication/screens/wishlist/wishlist_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final String documentId;

  const ProfileScreen({Key? key, required this.documentId}) : super(key: key);
  static String routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CollectionReference anonymous =
      FirebaseFirestore.instance.collection('anonymous');
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseAuth.instance.currentUser!.isAnonymous
          ? anonymous.doc(widget.documentId).get()
          : customers.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            //app bar
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: AppBarButton(
                prefixIcon: Icons.notifications,
                onTap: () {},
              ),
              title: const AppBarTitle(
                title: CbTextStrings.cbAppName,
              ),
              centerTitle: true,
              actions: [
                AppBarButton(
                  prefixIcon: Icons.search,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchScreen()),
                    );
                  },
                ),
                AppBarButton(
                  prefixIcon: Icons.shopping_cart,
                  onTap: () {},
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                /*
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 10,
          ),*/
                child: Column(
                  children: [
                    Center(
                      child: data['profileImage'] == ''
                          ? const CircleAvatar(
                              radius: 70,
                              backgroundImage: AssetImage(
                                'assets/images/user_images/user.gif',
                              ),
                            )
                          : CircleAvatar(
                              radius: 70,
                              backgroundImage:
                                  NetworkImage(data['profileImage']),
                            ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(data['name'] == ''
                        ? 'Invité(e)'.toUpperCase()
                        : data['name']),
                    Text(data['email'] == ''
                        ? 'example@email.com'
                        : data['email']),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: width * 0.8,
                      height: height * 0.06,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CbColors.cbPrimaryColor2,
                          side: BorderSide.none,
                          /*shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),*/
                        ),
                        child: const Text(
                          'Edit Profile',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ProfileMenuWidget(
                      title: 'Profile',
                      icon: Icons.person,
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WishlistScreen()),
                        );
                      },
                    ),
                    ProfileMenuWidget(
                      title: 'Wishlist',
                      icon: Icons.card_giftcard,
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WishlistScreen()),
                        );
                      },
                    ),
                    ProfileMenuWidget(
                      title: 'Your Orders',
                      icon: Icons.notifications,
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CustomerOrders()),
                        );
                      },
                    ),
                    ProfileMenuWidget(
                      title: 'Cart',
                      icon: Icons.notifications,
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CartScreen(back: AppBarBackButton())),
                        );
                      },
                    ),
                    ProfileMenuWidget(
                      title: 'Your Account',
                      icon: Icons.account_box,
                      onPress: () {},
                    ),
                    ProfileMenuWidget(
                      title: 'Settings',
                      icon: Icons.settings,
                      onPress: () {},
                    ),
                    ProfileMenuWidget(
                      title: 'Notifications',
                      icon: Icons.notifications,
                      onPress: () {},
                    ),
                    ProfileMenuWidget(
                      title: 'Logout',
                      icon: Icons.logout,
                      onPress: () async {
                        MyAlertDialog.showMyDialog(
                          context: context,
                          title: 'Log Out',
                          content: 'Are you sure you want to logout?',
                          onPressedNo: () {
                            Navigator.pop(context);
                          },
                          onPressedYes: () async {
                            await FirebaseAuth.instance.signOut();
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(
                                context, MainScreen.routeName);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(
            color: CbColors.cbPrimaryColor2,
          ),
        );
      },
    );
  }
}

class barDividerWidget extends StatelessWidget {
  const barDividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Divider(
        color: CbColors.cbPrimaryColor2,
        thickness: 1,
      ),
    );
  }
}

class ProfileMenuWidget2 extends StatelessWidget {
  const ProfileMenuWidget2({
    super.key,
    required this.title,
    this.subTitle,
    required this.icon,
    required this.onPressed,
    this.fontWeight,
  });

  final String title;
  final String? fontWeight;
  final String? subTitle;
  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight:
                fontWeight == 'bold' ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        subtitle: Text(
          subTitle!,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 11,
            //fontWeight: FontWeight.bold,
          ),
        ),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.iconColor,
    this.textColor,
    this.iconColor2,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? iconColor;
  final Color? iconColor2;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onPress,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: textColor,
              ),
        ),
        trailing: endIcon
            ? Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
              )
            : null);
  }
}
