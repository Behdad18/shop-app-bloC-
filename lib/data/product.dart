// product sorting options
class ProductSort {
  static const int latest = 0;
  static const int popular = 1;
  static const int priceHightoLow = 2;
  static const int priceLowtoHigh = 3;
}

// Product entity class representing a product object
class ProductEntity {
  final int id;
  final String title;
  final String imageUrl;
  final int price;
  final int discount;
  final int previousPrice;

  // Custom constructor to create a ProductEntity from JSON data
  ProductEntity.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      title = json['title'],
      imageUrl = json['image'],
      price = json['price'],
      previousPrice = json['previous_price'] ?? json['price'],
      discount = json['discount'];
}
