

class Product {
  String brand;
  String model;
  String name;
  double price;
  int quantity = 1;
  int qntty; //total in stock
  List imagesUrl;
  String documentId;
  String suppId;
  bool isFavorite;

  Product({
    required this.brand,
    required this.model,
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