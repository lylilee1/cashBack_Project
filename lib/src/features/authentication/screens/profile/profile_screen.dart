import 'package:cashback/src/common_widgets/app_bar/appBarWidget.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/screens/customer/customer_orders.dart';
import 'package:cashback/src/features/authentication/screens/main/main_screen2.dart';
import 'package:cashback/src/features/authentication/screens/search/search_screen.dart';
import 'package:cashback/src/features/authentication/screens/wishlist/wishlist_screen.dart';
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
              const Text('Elvis NDONG ESSONO'),
              const Text('superAdmin@cashback.com'),
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: height * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      ProfileMenuWidget2(
                        title: 'Profile',
                        fontWeight: 'bold',
                        subTitle:
                            'Please complete your profile to start personalized experience',
                        icon: Icons.person,
                        onPressed: () {},
                      ),
                      const barDividerWidget(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: height * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      ProfileMenuWidget2(
                        title: 'Wishlist',
                        fontWeight: 'bold',
                        subTitle:
                            'Please complete your personalized selected list of aticles',
                        icon: Icons.card_giftcard,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const WishlistScreen()),
                          );
                        },
                      ),
                      const barDividerWidget(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: height * 0.48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      ProfileMenuWidget2(
                        title: 'Your Order',
                        fontWeight: 'bold',
                        subTitle: '',
                        icon: Icons.person,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CustomerOrders()),
                          );
                        },
                      ),
                      ProfileMenuWidget2(
                        title: 'Track & Manage Your Orders',
                        fontWeight: '',
                        subTitle: '',
                        icon: Icons.spatial_tracking,
                        onPressed: () {},
                      ),
                      ProfileMenuWidget2(
                        title: 'Returns & Replacement',
                        fontWeight: '',
                        subTitle: '',
                        icon: Icons.keyboard_return,
                        onPressed: () {},
                      ),
                      ProfileMenuWidget2(
                        title: 'Shipping Rate & Policies',
                        fontWeight: '',
                        subTitle: '',
                        icon: Icons.local_shipping,
                        onPressed: () {},
                      ),
                      ProfileMenuWidget2(
                        title: 'Customer Service',
                        fontWeight: '',
                        subTitle: '',
                        icon: Icons.feedback,
                        onPressed: () {},
                      ),
                      const barDividerWidget(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: height * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      ProfileMenuWidget2(
                        title: 'Your Account',
                        fontWeight: 'bold',
                        subTitle: '',
                        icon: Icons.person,
                        onPressed: () {},
                      ),
                      ProfileMenuWidget2(
                        title: 'Lists',
                        fontWeight: '',
                        subTitle: '',
                        icon: Icons.spatial_tracking,
                        onPressed: () {},
                      ),
                      ProfileMenuWidget2(
                        title: 'Recommendations',
                        fontWeight: '',
                        subTitle: '',
                        icon: Icons.keyboard_return,
                        onPressed: () {},
                      ),
                      ProfileMenuWidget2(
                        title: 'Browsing History',
                        fontWeight: '',
                        subTitle: '',
                        icon: Icons.local_shipping,
                        onPressed: () {},
                      ),
                      const barDividerWidget(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: height * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      ProfileMenuWidget2(
                        title: 'Settings',
                        fontWeight: 'bold',
                        subTitle: '',
                        icon: Icons.person,
                        onPressed: () {},
                      ),
                      ProfileMenuWidget2(
                        title: 'Language',
                        fontWeight: '',
                        subTitle: '',
                        icon: Icons.spatial_tracking,
                        onPressed: () {},
                      ),
                      ProfileMenuWidget2(
                        title: 'Country',
                        fontWeight: '',
                        subTitle: '',
                        icon: Icons.keyboard_return,
                        onPressed: () {},
                      ),
                      ProfileMenuWidget2(
                        title: 'Sign Out',
                        fontWeight: '',
                        subTitle: '',
                        icon: Icons.local_shipping,
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, MainScreen.routeName);
                        },
                      ),
                    ],
                  ),
                ),
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
