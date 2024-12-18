import 'package:ecommerce_app/models/product_model.dart';

class CartItem {
  final String id;
  final Product product;
  final int quantity;
  final String selectedSize;
  final String selectedColor;
  final double price;
  final int bonusPoints;
  final int bonusPointsForSubscribers;

  CartItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.selectedSize,
    required this.selectedColor,
    required this.price,
    required this.bonusPoints,
    required this.bonusPointsForSubscribers,
  });

  

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] ?? '',
      product: Product.fromJson(map['product']),
      quantity: map['quantity'] ?? 1,
      selectedSize: map['selectedSize'] ?? '',
      selectedColor: map['selectedColor'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      bonusPoints: map['bonusPoints'] ?? 0,
      bonusPointsForSubscribers: map['bonusPointsForSubscribers'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product': product.toJson(),
      'quantity': quantity,
      'selectedSize': selectedSize,
      'selectedColor': selectedColor,
      'price': price,
      'bonusPoints': bonusPoints,
      'bonusPointsForSubscribers': bonusPointsForSubscribers,
    };
  }

  CartItem copyWith({
    String? id,
    Product? product,
    int? quantity,
    String? selectedSize,
    String? selectedColor,
    double? price,
    int? bonusPoints,
    int? bonusPointsForSubscribers,
  }) {
    return CartItem(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
      price: price ?? this.price,
      bonusPoints: bonusPoints ?? this.bonusPoints,
      bonusPointsForSubscribers: 
          bonusPointsForSubscribers ?? this.bonusPointsForSubscribers,
    );
  }
}
