class Product {
  final String? prodId;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Product(
      {this.prodId,
      required this.name,
      required this.description,
      required this.price,
      required this.imageUrl});

  Map<String, dynamic> toMap(String? id) {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl
    };
  }

  Product.fromMap(Map<String, dynamic> map)
      : prodId = map['id'] ?? "",
        name = map['name'] ?? "",
        description = map['description'] ?? "",
        price = map['price'] ?? 0.0,
        imageUrl = map['imageUrl'] ?? "";
}
