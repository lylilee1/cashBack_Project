
import 'package:flutter/material.dart';
import 'package:cashback/src/constants/image_strings.dart';

class DashboardCarouselModel {
  final String image;
  final String? title;
  final String? description;
  final VoidCallback? onTap;

  DashboardCarouselModel({required this.image, this.title, this.description, this.onTap});

  static List<DashboardCarouselModel> list = [
      DashboardCarouselModel(
        image: CbImageStrings.cbC1,
        title: "Welcome to Cashback",
        description: "Cashback is a mobile app that allows you to earn cashback on your purchases.",
        onTap: () {},
      ),
      DashboardCarouselModel(
        image: CbImageStrings.cbC2,
        title: "Welcome to Cashback",
        description: "Cashback is a mobile app that allows you to earn cashback on your purchases.",
        onTap: () {},
      ),
    ];

}
