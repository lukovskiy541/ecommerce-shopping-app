// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    };
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      subCategories: (json['subCategories'] as List<dynamic>)
          .map((sub) => SubCategory.fromJson(sub))
          .toList(),
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
      id: json['id'],
      name: json['name'],
      imageUrl: json['nimageUrlme'],

    );
  }
}