class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final List<String> availableSizes;
  final List<String> availableColors;
  final int bonusPoints;
  final int bonusPointsForSubscribers;
  final String brand;
  final String seller;
  final bool isFavorite;
  final int stock;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.availableSizes,
    required this.availableColors,
    required this.bonusPoints,
    required this.bonusPointsForSubscribers,
    required this.brand,
    required this.seller,
    this.isFavorite = false,
    this.stock = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'availableSizes': availableSizes,
      'availableColors': availableColors,
      'bonusPoints': bonusPoints,
      'bonusPointsForSubscribers': bonusPointsForSubscribers,
      'brand': brand,
      'seller': seller,
      'isFavorite': isFavorite,
      'stock': stock,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      category: json['category'],
      availableSizes: List<String>.from(json['availableSizes']),
      availableColors: List<String>.from(json['availableColors']),
      bonusPoints: json['bonusPoints'],
      bonusPointsForSubscribers: json['bonusPointsForSubscribers'],
      brand: json['brand'],
      seller: json['seller'],
      isFavorite: json['isFavorite'] ?? false,
      stock: json['stock'] ?? 0,
    );
  }
}
