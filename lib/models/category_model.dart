import 'package:cloud_firestore/cloud_firestore.dart';

class Gender {
  final String id;
  final String name;
  final String imageUrl;
  final List<ProductType> productTypes;

  Gender({
    required this.id,
    required this.name,
    this.imageUrl = '',
    required this.productTypes,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'productTypes': productTypes.map((type) => type.toJson()).toList(),
    };
  }

  factory Gender.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    List<ProductType> productTypes = [];
    if (data['productTypes'] != null) {
      productTypes = (data['productTypes'] as List)
          .map((typeData) => ProductType.fromMap(typeData))
          .toList();
    }

    return Gender(
      id: doc.id,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      productTypes: productTypes,
    );
  }

  factory Gender.fromJson(Map<String, dynamic> json) {
    return Gender(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      productTypes: json['productTypes'] != null
          ? (json['productTypes'] as List)
              .map((type) => ProductType.fromJson(type))
              .toList()
          : [],
    );
  }
}

class ProductType {
  final String id;
  final String name;
  final String imageUrl;
  final List<Category> categories;

  ProductType({
    required this.id,
    required this.name,
    this.imageUrl = '',
    required this.categories,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'categories': categories.map((category) => category.toJson()).toList(),
    };
  }

  factory ProductType.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    List<Category> categories = [];
    if (data['categories'] != null) {
      categories = (data['categories'] as List)
          .map((categoryData) => Category.fromMap(categoryData))
          .toList();
    }

    return ProductType(
      id: doc.id,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      categories: categories,
    );
  }

  factory ProductType.fromJson(Map<String, dynamic> json) {
    return ProductType(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      categories: json['categories'] != null
          ? (json['categories'] as List)
              .map((category) => Category.fromJson(category))
              .toList()
          : [],
    );
  }

  factory ProductType.fromMap(Map<String, dynamic> map) {
    return ProductType(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      categories: map['categories'] != null
          ? (map['categories'] as List)
              .map((category) => Category.fromMap(category))
              .toList()
          : [],
    );
  }
}

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
      'imageUrl': imageUrl,
      'subCategories': subCategories.map((sub) => sub.toJson()).toList(),
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
      imageUrl: data['imageUrl'] ?? '',
      subCategories: subCategories,
    );
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      subCategories: json['subCategories'] != null
          ? (json['subCategories'] as List)
              .map((sub) => SubCategory.fromJson(sub))
              .toList()
          : [],
    );
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      subCategories: map['subCategories'] != null
          ? (map['subCategories'] as List)
              .map((sub) => SubCategory.fromMap(sub))
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  factory SubCategory.fromFirestore(dynamic data) {
    Map<String, dynamic> mapData =
        data is DocumentSnapshot ? data.data() as Map<String, dynamic> : data;

    return SubCategory(
      id: mapData['id'] ?? '',
      name: mapData['name'] ?? '',
      imageUrl: mapData['imageUrl'] ?? '',
    );
  }

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  factory SubCategory.fromMap(Map<String, dynamic> map) {
    return SubCategory(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}
