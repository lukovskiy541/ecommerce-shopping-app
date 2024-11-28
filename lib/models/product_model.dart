// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  factory Product.fromFirestore(DocumentSnapshot doc) {
  Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  return Product(
    id: doc.id, // Використовуємо id документа з Firestore
    name: data['name'] ?? '',
    description: data['description'] ?? '',
    price: (data['price'] ?? 0.0).toDouble(),
    imageUrl: data['imageUrl'],
    category: data['category'],
    subCategory: data['subCategory'] ?? '',
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
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      category: json['category'],
      subCategory: json['category'],
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
