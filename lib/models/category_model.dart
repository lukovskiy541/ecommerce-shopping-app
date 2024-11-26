class Category {
  final String id;
  final String name;
  final List<SubCategory> subCategories;

  Category({
    required this.id,
    required this.name,
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
      subCategories: (json['subCategories'] as List<dynamic>)
          .map((sub) => SubCategory.fromJson(sub))
          .toList(),
    );
  }
}

class SubCategory {
  final String id;
  final String name;
  final String parentCategoryId;

  SubCategory({
    required this.id,
    required this.name,
    required this.parentCategoryId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parentCategoryId': parentCategoryId,
    };
  }

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      name: json['name'],
      parentCategoryId: json['parentCategoryId'],
    );
  }
}