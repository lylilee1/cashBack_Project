import 'package:cashback/src/features/authentication/controllers/product/product_controller.dart';
import 'package:flutter/foundation.dart';

class Wish extends ChangeNotifier {
  final List<Product> _list = [];

  List<Product> get getWishItems {
    return _list;
  }

  int? get WishItemCount {
    _list.length;
  }

  Future<void> addWishItem(
      String brand,
      String model,
      String name,
      double price,
      int quantity,
      int qntty, //total in stock
      List imagesUrl,
      String documentId,
      String suppId,
      bool isFavorite,
      ) async {
    final product = Product(
      brand: brand,
      model: model,
      name: name,
      price: price,
      quantity: quantity,
      qntty: qntty,
      imagesUrl: imagesUrl,
      documentId: documentId,
      suppId: suppId,
      isFavorite: isFavorite,
    );
    _list.add(product);
    notifyListeners();
  }

  void removeWishItem(Product product) {
    _list.remove(product);
    notifyListeners();
  }

  void clearWishlist() {
    _list.clear();
    notifyListeners();
  }

  void removeThis (String id){
    _list.removeWhere((element) => element.documentId == id);
    notifyListeners();
  }

}
