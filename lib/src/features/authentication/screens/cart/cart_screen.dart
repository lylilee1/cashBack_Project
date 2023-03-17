import 'package:cashback/src/common_widgets/app_bar/appBarWidget.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/image_strings.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../customer/customer_home_screen4.dart';

class CartScreen extends StatefulWidget {
  final Widget? back;
  const CartScreen({Key? key, this.back}) : super(key: key);
  static String routeName = '/cart';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Scaffold(
      //app bar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading:widget.back,
        //AppBarButton(prefixIcon: Icons.notifications, onTap: () {},),
        title: AppBarTitle(title: CbTextStrings.cbAppName,),
        centerTitle: true,
        actions: [
          AppBarButton(prefixIcon: Icons.search, onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchScreen()),
            );
          },),
          AppBarButton(prefixIcon: Icons.shopping_cart, onTap: () {},),
        ],
      ),
      body: Material(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Panier vide',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
                  child: Text(
                    'La page que vous recherchez n\'existe pas ou a été déplacée.',
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: height * 0.05),
                MaterialButton(
                  onPressed: () {
                    Navigator.canPop(context)
                        ? Navigator.pop(context)
                        :
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CustomerHomeScreen()));
                  },
                  color: CbColors.cbPrimaryColor2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Text(
                    'Continuer vos achats',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Row(
        children: [
          Container(
            height: height * 0.05,
            width: width * 0.5,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  CbImageStrings.cbSvgCart,
                  height: height * 0.03,
                  color: Colors.black87,
                ),
                /*Text(
                  'Panier',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: CbColors.cbPrimaryColor2, //Colors.white,
                      ),
                ),*/
                Text(
                  '00.00',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: CbColors.cbPrimaryColor2,//Colors.white,
                  ),
                ),
                Text(
                  '\XAF',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: CbColors.cbPrimaryColor2,//Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: height * 0.05,
            width: width * 0.5,
            decoration: BoxDecoration(
              color: CbColors.cbPrimaryColor2,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Commander',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Colors.white,
                      ),
                ),
                SvgPicture.asset(
                  CbImageStrings.cbSvgArrow,
                  height: height * 0.02,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
