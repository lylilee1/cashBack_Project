
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/image_strings.dart';
import 'package:cashback/src/features/authentication/screens/customer/minor_screen/full_screen_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class ProductDetailsScreen extends StatefulWidget {
  final dynamic prodList;

  const ProductDetailsScreen({Key? key, required this.prodList})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late List<dynamic> imagesList = widget.prodList['proimages'];

  @override
  Widget build(BuildContext context) {
    bool isFavorite = false;

    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    final Stream<QuerySnapshot> productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('maincateg', isEqualTo: widget.prodList['maincateg'])
        .where('subcateg', isEqualTo: widget.prodList['subcateg'])
        .snapshots();

    return

    Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black87,
                Color(0xFFE8E8E8),
              ],
            ),
          ),
          child: Stack(
            children: [
              //top images carousel slider
              Positioned(
                top: 0,
                left: 0,
                child: SizedBox(
                  width: width,
                  height: height * 0.45,
                  child: Swiper(
                    itemCount: imagesList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullScreenView(
                                imagesList: imagesList,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: width,
                          height: height * 0.5,
                          //margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(imagesList[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                    pagination: const SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                        color: Colors.grey,
                        activeColor: CbColors.cbPrimaryColor2,
                      ),
                    ),
                    control: const SwiperControl(
                      color: CbColors.cbPrimaryColor2,
                    ),
                    autoplay: true,
                    autoplayDelay: 5000,
                    autoplayDisableOnInteraction: true,
                    loop: true,
                  ),
                ),
              ),

              //buttons positioning
              Positioned(
                top: height * 0.05,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //back button
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 44,
                          width: 44,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 3,
                              color: CbColors.cbPrimaryColor2,
                            ),
                          ),
                          child: SvgPicture.asset(
                            CbImageStrings.cbIconBack,
                            color: CbColors.cbPrimaryColor2,
                          ),
                        ),
                      ),

                      //menu button
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 44,
                          width: 44,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 3,
                              //color: CbColors.cbPrimaryColor2,
                              color: const Color(0xff404c57),
                            ),
                          ),
                          child: SvgPicture.asset(
                            CbImageStrings.cbIconMenu,
                            //color: CbColors.cbPrimaryColor2,
                            color: const Color(0xff404c57),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //product image
              Positioned(
                right: 9,
                top: height * 0.35,
                child: Container(
                  width: 150,
                  height: 150,
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        CbColors.cbPrimaryColor2,
                        CbColors.cbPrimaryColor3,
                      ],
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(widget.prodList['proimages'][0]),
                        fit: BoxFit.cover,
                      ),
                    ),

                    /*
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        widget.prodList['proimages'][0],
                        fit: BoxFit.cover,
                      ),
                    ),*/
                    /*const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),*/
                  ),
                ),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: height * 0.45,
                  transform: Matrix4.translationValues(0, -height * 0.05, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width * 0.7,
                        child: Column(
                          children: [
                            Text(
                              'Eternals',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white.withOpacity(
                                  0.85,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height <= 667 ? 10 : 20,
                            ),
                            Text(
                              '2021•Action-Adventure-Fantasy•2h36m',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white.withOpacity(
                                  0.75,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            /*   RatingBar.builder(
                              itemSize: 14,
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemPadding:
                              const EdgeInsets.symmetric(horizontal: 1),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              onRatingUpdate: (rating) {
                                debugPrint(rating.toString());
                              },
                              unratedColor: Colors.white,
                            ),*/
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'The saga of the Eternals, a race of\nimmortal beings who lived on Earth\nand shaped its history and\ncivilizations.',
                              textAlign: TextAlign.center,
                              maxLines: height <= 667 ? 2 : 4,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withOpacity(
                                  0.75,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Container(
                        height: 2,
                        width: width * 0.8,
                        color: Colors.white.withOpacity(0.15),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 23,
                        ),
                        // color: Colors.amber,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Row(
                              children: [
                                Text(
                                  'Casts',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height <= 667 ? 10 : 18,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.orange,
                                  minRadius: 16,
                                  maxRadius: width <= 375 ? 24 : 30,
                                  backgroundImage: const NetworkImage(
                                    'https://m.media-amazon.com/images/M/MV5BODg3MzYwMjE4N15BMl5BanBnXkFtZTcwMjU5NzAzNw@@._V1_.jpg',
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    constraints: const BoxConstraints(
                                      maxHeight: 50,
                                      maxWidth: 112,
                                    ),
                                    transform:
                                    Matrix4.translationValues(-6, 0, 0),
                                    child: const Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        /*MaskedImage(
                                          asset: Constants.kMaskCast,
                                          mask: Constants.kMaskCast,
                                        ),*/
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 16.0,
                                          ),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Angelina\nJolie',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                              ),
                                              maxLines: 2,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.orange,
                                  minRadius: 16,
                                  maxRadius: width <= 375 ? 24 : 30,
                                  backgroundImage: const NetworkImage(
                                    'https://m.media-amazon.com/images/M/MV5BODg3MzYwMjE4N15BMl5BanBnXkFtZTcwMjU5NzAzNw@@._V1_.jpg',
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    constraints: const BoxConstraints(
                                      maxHeight: 50,
                                      maxWidth: 112,
                                    ),
                                    transform:
                                    Matrix4.translationValues(-6, 0, 0),
                                    child: const Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        /*MaskedImage(
                                          asset: Constants.kMaskCast,
                                          mask: Constants.kMaskCast,
                                        ),*/
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 16.0,
                                          ),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Angelina\nJolie',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                              ),
                                              maxLines: 2,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.orange,
                                  minRadius: 16,
                                  maxRadius: width <= 375 ? 24 : 30,
                                  backgroundImage: const NetworkImage(
                                    'https://m.media-amazon.com/images/M/MV5BODg3MzYwMjE4N15BMl5BanBnXkFtZTcwMjU5NzAzNw@@._V1_.jpg',
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    constraints: const BoxConstraints(
                                      maxHeight: 50,
                                      maxWidth: 112,
                                    ),
                                    transform:
                                    Matrix4.translationValues(-6, 0, 0),
                                    child: const Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        /*MaskedImage(
                                          asset: Constants.kMaskCast,
                                          mask: Constants.kMaskCast,
                                        ),*/
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 16.0,
                                          ),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Angelina\nJolie',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                              ),
                                              maxLines: 2,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.orange,
                                  minRadius: 16,
                                  maxRadius: width <= 375 ? 24 : 30,
                                  backgroundImage: const NetworkImage(
                                    'https://m.media-amazon.com/images/M/MV5BODg3MzYwMjE4N15BMl5BanBnXkFtZTcwMjU5NzAzNw@@._V1_.jpg',
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    constraints: const BoxConstraints(
                                      maxHeight: 50,
                                      maxWidth: 112,
                                    ),
                                    transform:
                                    Matrix4.translationValues(-6, 0, 0),
                                    child: const Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        /*MaskedImage(
                                          asset: Constants.kMaskCast,
                                          mask: Constants.kMaskCast,
                                        ),*/
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 16.0,
                                          ),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Angelina\nJolie',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                              ),
                                              maxLines: 2,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
