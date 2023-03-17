import 'package:cashback/src/common_widgets/Alert/alert_dialog.dart';
import 'package:cashback/src/common_widgets/app_bar/appBarWidget.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/image_strings.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/screens/cart/cart_screen.dart';
import 'package:cashback/src/features/authentication/screens/customer/customer_orders.dart';
import 'package:cashback/src/features/authentication/screens/main/main_screen2.dart';
import 'package:cashback/src/features/authentication/screens/search/search_screen.dart';
import 'package:cashback/src/features/authentication/screens/wishlist/wishlist_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static String routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Scaffold(
      //app bar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: AppBarButton(
          prefixIcon: Icons.notifications,
          onTap: () {},
        ),
        title: AppBarTitle(
          title: CbTextStrings.cbAppName,
        ),
        centerTitle: true,
        actions: [
          AppBarButton(
            prefixIcon: Icons.search,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
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
              const Center(
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage(
                    'assets/images/user_images/user.gif',
                  ),
                ),
              ),
              /*
              SizedBox(
                width: width * 0.5,
                height: height * 0.23,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image(
                    image: AssetImage(
                        'assets/images/user_images/user.gif'),
                  ),
                ),
              ),*/
              const SizedBox(
                height: 10,
              ),
              Text('Elvis NDONG ESSONO'),
              Text('superAdmin@cashback.com'),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: width * 0.8,
                height: height * 0.06,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Edit Profile',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CbColors.cbPrimaryColor2,
                    side: BorderSide.none,
                    /*shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),*/
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
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class barDividerWidget extends StatelessWidget {
  const barDividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
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
          style: TextStyle(
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
