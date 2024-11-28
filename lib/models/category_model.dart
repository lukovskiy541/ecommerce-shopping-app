import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String id;
  final String name;
  final String imageUrl;
  final List<SubCategory> subCategories;

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.subCategories,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'subCategories': subCategories.map((sub) => sub.toJson()).toList(),
      'imageUrl': imageUrl
    };
  }
  
  factory Category.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    List<SubCategory> subCategories = [];
    if (data['subCategories'] != null) {
      subCategories = (data['subCategories'] as List)
          .map((subCategoryData) => SubCategory.fromMap(subCategoryData))
          .toList();
    }

    return Category(
      id: doc.id,
      name: data['name'] ?? '',
      subCategories: subCategories,
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      subCategories: json['subCategories'] != null
          ? (json['subCategories'] as List<dynamic>)
              .map((sub) => SubCategory.fromJson(sub))
              .toList()
          : [],
    );
  }
}

class SubCategory {
  final String id;
  final String name;
  final String imageUrl;

  SubCategory({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory SubCategory.fromFirestore(dynamic data) {
    // Handle both Map and DocumentSnapshot inputs
    Map<String, dynamic> mapData = data is DocumentSnapshot 
        ? data.data() as Map<String, dynamic>
        : data;

    return SubCategory(
      id: mapData['id'] ?? '',
      name: mapData['name'] ?? '',
      imageUrl: mapData['imageUrl'] ?? '',
    );
  }

  factory SubCategory.fromMap(Map<String, dynamic> map) {
    return SubCategory(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}