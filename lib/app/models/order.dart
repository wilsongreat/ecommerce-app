import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/app/models/product_model.dart';

class Order {
  String confirmationId;
  Timestamp timestamp;
  List<Product> products;

  Order(
      {required this.confirmationId,
      required this.products,
      required this.timestamp});

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      confirmationId: map['confirmationId'],
      timestamp: map['timestamps'],
      products: (map['products'] as List<dynamic>)
          .map((product) => Product.fromMap(product))
          .toList(),
    );
  }

  // mapOrder(Map<String, dynamic> map) {
  //   return Order(
  //       confirmationId: map['confirmationId'],
  //       products: (map['products'] as List<dynamic>)
  //           .map((product) => Product.fromMap(product))
  //           .toList(),
  //       timestamp: map['timestamps']);
  // }
}
