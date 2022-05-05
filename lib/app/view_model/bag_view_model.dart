import 'package:ecommerce/app/models/product_model.dart';
import 'package:flutter/cupertino.dart';

class BagViewModel extends ChangeNotifier {
  final List<Product> productsBag;

  BagViewModel() : productsBag = [];

  void addProduct(Product product) {
    productsBag.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    productsBag.remove(product);
    notifyListeners();
  }

  void clearBag(Product product) {
    productsBag.clear();
    notifyListeners();
  }

  int get totalProducts => productsBag.length;

  double get totalPrice => productsBag.fold(0, (total, product) {
        return total + product.price;
      });
  bool get isBagEmpty => productsBag.isEmpty;
}
