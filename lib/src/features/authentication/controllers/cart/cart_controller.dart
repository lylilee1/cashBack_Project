import 'package:cashback/src/features/authentication/controllers/product/product_controller.dart';
import 'package:flutter/foundation.dart';

class Cart extends ChangeNotifier {
  final List<Product> _list = [];

  List<Product> get getitems {
    return _list;
  }

  //getter
  double get totalPrice {
    var total = 0.0;

    for(var item in _list){
      total += item.price * item.quantity;
    }

    /*_list.forEach((product) {
      total += product.price * product.quantity;
    });*/
    return total;
  }

  int? get itemCount {
    _list.length;
    return null;
  }

  void addItem(
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
      ) {
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

  void increment(Product product) {
    product.increase();
    notifyListeners();
  }

  void decrement(Product product) {
    product.decrease();
    notifyListeners();
  }

  void removeItem(Product product) {
    _list.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _list.clear();
    notifyListeners();
  }

  void removeThis (String id){
    _list.removeWhere((element) => element.documentId == id);
    notifyListeners();
  }



/*
  List<Product> _items = [];

  List<Product> get items => _items;

  int get itemCount => _items.length;

  double get totalAmount {
    double total = 0.0;
    _items.forEach((product) {
      total += product.price * product.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void removeItem(Product product) {
    _items.remove(product);
    notifyListeners();
  }

  void clear() {
    _items = [];
    notifyListeners();
  }*/
}
