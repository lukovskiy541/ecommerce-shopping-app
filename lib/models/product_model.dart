import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ecommerce_app/models/category_model.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final Category category;
  final SubCategory subCategory;
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
    required this.subCategory,
    required this.availableSizes,
    required this.availableColors,
    required this.bonusPoints,
    required this.bonusPointsForSubscribers,
    required this.brand,
    required this.seller,
    this.isFavorite = false,
    this.stock = 0,
  });

  factory Product.fromFirestore(dynamic doc) {
    Map<String, dynamic> data;
    String id;

    // Explicitly handle different input types
    if (doc is DocumentSnapshot) {
      // If it's a DocumentSnapshot, extract data and ID
      data = doc.data() as Map<String, dynamic>;
      id = doc.id;
    } else if (doc is Map<String, dynamic>) {
      // If it's a direct Map, use it as-is
      data = doc;
      id = data['id'] ?? '';
    } else {
      throw ArgumentError(
          'Invalid input type for Product.fromFirestore. Expected DocumentSnapshot or Map<String, dynamic>.');
    }

    // Safely handle category and subCategory parsing
    Category category = data['category'] is Map<String, dynamic>
        ? Category.fromJson(data['category'])
        : Category.fromFirestore(data['category']);

    SubCategory subCategory = data['subCategory'] is Map<String, dynamic>
        ? SubCategory.fromJson(data['subCategory'])
        : SubCategory.fromFirestore(data['subCategory']);

    return Product(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      imageUrl: data['imageUrl'] ?? '',
      category: category,
      subCategory: subCategory,
      availableSizes: List<String>.from(data['availableSizes'] ?? []),
      availableColors: List<String>.from(data['availableColors'] ?? []),
      bonusPoints: data['bonusPoints'] ?? 0,
      bonusPointsForSubscribers: data['bonusPointsForSubscribers'] ?? 0,
      brand: data['brand'] ?? '',
      seller: data['seller'] ?? '',
      isFavorite: data['isFavorite'] ?? false,
      stock: data['stock'] ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category.toJson(), // Ensure category is converted to JSON
      'subCategory':
          subCategory.toJson(), // Ensure subCategory is converted to JSON
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category.toJson(),
      'subCategory': subCategory.toJson(),
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
    Category category = Category.fromJson(json['category']);
    SubCategory subCategory = SubCategory.fromJson(json['subCategory']);

    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      category: category,
      subCategory: subCategory,
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
