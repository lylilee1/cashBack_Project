import 'package:flutter/cupertino.dart';

class Product {
  String name;
  double price;
  int quantity = 1;
  int qntty; //total in stock
  List imagesUrl;
  String documentId;
  String suppId;
  bool isFavorite;

  Product({
    required this.name,
    required this.price,
    required this.quantity,
    required this.qntty,
    required this.imagesUrl,
    required this.documentId,
    required this.suppId,
    this.isFavorite = false,
  });

  void increase () {
    quantity++;
    //notifyListeners();
  }
  void decrease () {
    quantity--;
    //notifyListeners();
  }

}

class Cart extends ChangeNotifier {
  final List<Product> _list = [];

  List<Product> get getitems {
    return _list;
  }

  int? get itemCount {
    _list.length;
  }

  void addItem(
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
