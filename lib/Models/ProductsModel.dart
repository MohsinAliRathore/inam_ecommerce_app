class Product {
  final int id;
  final String name;
  final String categoryId;
  final String price;
  final String image;
  final bool bulkPriceAvailable;
  final String? bulkPrice;
  final String? bulkQty;
  final String minQty;
  final String available;
  final DateTime createdAt;
  final DateTime updatedAt;
  int quantity; // New attribute for quantity

  Product({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.price,
    required this.image,
    required this.bulkPriceAvailable,
    this.bulkPrice,
    this.bulkQty,
    required this.minQty,
    required this.available,
    required this.createdAt,
    required this.updatedAt,
    this.quantity = 0, // Default quantity is set to 0
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      categoryId: json['category_id'],
      price: json['price'],
      image: json['image'],
      bulkPriceAvailable: json['bulk_price_available'] == "1",
      bulkPrice: json['bulk_price'],
      bulkQty: json['bulk_qty'],
      minQty: json['min_qty'],
      available: json['available'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}