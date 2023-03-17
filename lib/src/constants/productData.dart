import 'dart:ui';


class CbProduct{
  // -- App default category
  CbProduct._(this.productName, this.productImage, this.currentPrice, this.oldPrice, this.isLiked,);

  final String productName;
  final String productImage;
  final String currentPrice;
  final String oldPrice;
  final bool isLiked;
}