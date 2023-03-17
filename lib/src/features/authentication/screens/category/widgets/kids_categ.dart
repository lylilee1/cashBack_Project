import 'package:cashback/src/constants/categoryData.dart';
import 'package:cashback/src/features/authentication/models/category/category_model.dart';
import 'package:flutter/material.dart';

class KidsCategory extends StatelessWidget {
  const KidsCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              height: height * 0.8,
              width: width * 0.75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CategoryHeaderLabel(
                    headerLabel: 'Kids',
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.68,
                    child: GridView.count(
                      mainAxisSpacing: 70,
                      crossAxisSpacing: 15,
                      crossAxisCount: 3,
                      children: List.generate(
                        kids.length,
                            (index) {
                          return SubCategoryModel(subCategName: kids[index], mainCategName: 'kids', assetName: 'assets/images/articles/kids/kids$index.jpg', subCategLabel: kids[index],);
                          /*return Container(
                          //color: Colors.blue,
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.only(left: 10,),
                          height: size.height * 0.21,
                          width: size.width * 1,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15),
                           /* image: DecorationImage(
                              image: AssetImage(ads[index]),
                              fit: BoxFit.fill,
                            ),*/
                          ),
                        );*/
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SliderBar(height: height, width: width, mainCategoryName: 'kids',),
          ),
        ],
      ),
    );
  }
}
