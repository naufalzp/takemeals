class Product {
  final int id;
  final int partnerId;
  final String name;
  final String description;
  final String typeFood;
  final double price;
  final int stock;
  final int expired;
  final String image;

  Product({
    required this.id,
    required this.partnerId,
    required this.name,
    required this.description,
    required this.typeFood,
    required this.price,
    required this.stock,
    required this.expired,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      partnerId: json['partner_id'],
      name: json['name'],
      description: json['description'],
      typeFood: json['type_food'],
      price: double.parse(json['price']),
      stock: json['stock'],
      expired: json['expired'],
      image: json['image'],
    );
  }
}
