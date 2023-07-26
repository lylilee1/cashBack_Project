import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashback/src/common_widgets/Alert/alert_dialog.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/size_config.dart';
import 'package:cashback/src/features/authentication/screens/main/main_screen2.dart';
import 'package:cashback/src/features/authentication/screens/profile/update_profile_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../common_widgets/app_bar/appBarWidget.dart';
import '../../../../constants/app_styles.dart';
import '../customer/minor_screen/customer_order1.dart';
import '../product/product_details_screen7.dart';

class ProfileScreen extends StatefulWidget {
  final String documentId;

  const ProfileScreen({Key? key, required this.documentId}) : super(key: key);
  static String routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');
  CollectionReference anonymous =
      FirebaseFirestore.instance.collection('anonymous');

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseAuth.instance.currentUser!.isAnonymous
          ? anonymous.doc(widget.documentId).get()
          : customers.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Quelque chose s'est mal passé");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Le document n'existe pas");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CbColors.cbPrimaryColor2,
              elevation: 0,
              centerTitle: true,
              title: const AppBarTitle(
                title: 'Profil',
                iconColor: CbColors.cbWhiteColor,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 50),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    /*Color(0xff0043ba),
                                    Color(0xff006df1),*/
                                    CbColors.cbPrimaryColor2!.withOpacity(0.4),
                                    CbColors.cbPrimaryColor2,
                                  ]),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              )),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: 150,
                            height: 150,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                //Profile image
                                CachedNetworkImage(
                                  imageUrl: data['profileImage'] == ''
                                      ? 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80'
                                      : data['profileImage'],
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: imageProvider,
                                      ),
                                    ),
                                  ),
                                ),

                                //Edit profile button
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    child: Container(
                                        margin: const EdgeInsets.all(4.0),
                                        decoration: const BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const UpdateProfileScreen(),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          //Name
                          Text(
                            data['name'] == '' ? 'Invité(e)' : data['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: cbBebasNeueBold.copyWith(
                              fontSize: SizeConfig.blockSizeHorizontal! * 5,
                              color: kBlack,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 24),
                          //const _ProfileInfoRow()

                          //Account Info Title
                          const ProDetailsHeaderWidget(
                            label: '  Mon compte  ',
                          ),
                         /* SizedBox(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  height: 40,
                                  width: 50,
                                  child: Divider(
                                    color: CbColors.cbPrimaryColor2,
                                    thickness: 1,
                                  ),
                                ),
                                Text(
                                  'Mon compte',
                                  style: TextStyle(
                                    fontFamily: 'Intro Inline',
                                    fontSize:
                                    SizeConfig.blockSizeHorizontal! * 5,
                                    color: CbColors.cbPrimaryColor2,
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                  width: 50,
                                  child: Divider(
                                    color: CbColors.cbPrimaryColor2,
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),*/

                          //Account
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 0,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2.5,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 5), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.person,
                                  color: CbColors.cbPrimaryColor2,
                                ),
                                title: Text(
                                  'Mes informations perso',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: CbColors.cbPrimaryColor2,
                                ),
                              ),
                            ),
                          ),

                          //Orders
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CustomerOrders(
                                    back: AppBarBackButton(iconColor: CbColors.cbWhiteColor,),
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 15,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2.5,
                                      blurRadius: 5,
                                      offset: const Offset(
                                          0, 5), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.shopping_bag_outlined,
                                    color: CbColors.cbPrimaryColor2,
                                  ),
                                  title: Text(
                                    'Mes commandes',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: CbColors.cbPrimaryColor2,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          //Sell my products
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 15,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2.5,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 5), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.replay_circle_filled,
                                  color: CbColors.cbPrimaryColor2,
                                ),
                                title: Text(
                                  'Revendre mes produits',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: CbColors.cbPrimaryColor2,
                                ),
                              ),
                            ),
                          ),

                          //Recommandations
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 15,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2.5,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 5), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.person,
                                  color: CbColors.cbPrimaryColor2,
                                ),
                                title: Text(
                                  'Mes recommandations',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: CbColors.cbPrimaryColor2,
                                ),
                              ),
                            ),
                          ),

                          //Preferences
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 15,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2.5,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 5), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.email_outlined,
                                  color: CbColors.cbPrimaryColor2,
                                ),
                                title: Text(
                                  'Mes préférences',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: CbColors.cbPrimaryColor2,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          //const _ProfileInfoRow()

                          //Help Title
                          const ProDetailsHeaderWidget(
                            label: '  Aide  ',
                          ),

                          //Call us
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 0,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2.5,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 5), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.replay_circle_filled,
                                  color: CbColors.cbPrimaryColor2,
                                ),
                                title: Text(
                                  'Nous contacter',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: CbColors.cbPrimaryColor2,
                                ),
                              ),
                            ),
                          ),

                          //FAQ
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 15,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2.5,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 5), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.replay_circle_filled,
                                  color: CbColors.cbPrimaryColor2,
                                ),
                                title: Text(
                                  'Questions fréquentes',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: CbColors.cbPrimaryColor2,
                                ),
                              ),
                            ),
                          ),

                          //Terms and policy
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 15,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2.5,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 5), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.replay_circle_filled,
                                  color: CbColors.cbPrimaryColor2,
                                ),
                                title: Text(
                                  'Termes et politiques',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: CbColors.cbPrimaryColor2,
                                ),
                              ),
                            ),
                          ),

                          //Privacy policy
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 15,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2.5,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 5), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.replay_circle_filled,
                                  color: CbColors.cbPrimaryColor2,
                                ),
                                title: Text(
                                  'Politique de confidentialité',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: CbColors.cbPrimaryColor2,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          //Sign Out
                          InkWell(
                            onTap: () async {
                              MyAlertDialog.showMyDialog(
                                context: context,
                                title: 'Log Out',
                                content: 'Are you sure you want to logout?',
                                onPressedNo: () {
                                  Navigator.pop(context);
                                },
                                onPressedYes: () async {
                                  await FirebaseAuth.instance.signOut();

                                  await Future.delayed(
                                    const Duration(microseconds: 100),
                                  ).whenComplete(() {
                                    Navigator.pop(context);
                                    Navigator.pushReplacementNamed(
                                        context, MainScreen.routeName);
                                  });
                                },
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 15,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2.5,
                                      blurRadius: 5,
                                      offset: const Offset(
                                          0, 5), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.logout,
                                    color: CbColors.cbPrimaryColor2,
                                  ),
                                  title: Text(
                                    'Se déconnecter',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: CbColors.cbPrimaryColor2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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

class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow({Key? key}) : super(key: key);

  final List<ProfileInfoItem> _items = const [
    ProfileInfoItem("Posts", 900),
    ProfileInfoItem("Followers", 120),
    ProfileInfoItem("Following", 200),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      constraints: const BoxConstraints(maxWidth: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _items
            .map((item) => Expanded(
                    child: Row(
                  children: [
                    if (_items.indexOf(item) != 0) const VerticalDivider(),
                    Expanded(child: _singleItem(context, item)),
                  ],
                )))
            .toList(),
      ),
    );
  }

  Widget _singleItem(BuildContext context, ProfileInfoItem item) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.value.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Text(
            item.title,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      );
}

class ProfileInfoItem {
  final String title;
  final int value;

  const ProfileInfoItem(this.title, this.value);
}
