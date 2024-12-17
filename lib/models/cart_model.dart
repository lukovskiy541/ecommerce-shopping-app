
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/cart_item_model.dart';

class Cart {
  final String id;
  final String userId;
  final List<CartItem> items;
  final double totalPrice;
  final int totalBonusPoints;
  final int totalBonusPointsForSubscribers;
  final DateTime updatedAt;

  Cart({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalPrice,
    required this.totalBonusPoints,
    required this.totalBonusPointsForSubscribers,
    required this.updatedAt,
  });

  factory Cart.initial(String userId) {
    return Cart(
      id: '',
      userId: userId,
      items: [],
      totalPrice: 0.0,
      totalBonusPoints: 0,
      totalBonusPointsForSubscribers: 0,
      updatedAt: DateTime.now(),
    );
  }

  factory Cart.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Cart(
      id: doc.id,
      userId: data['userId'] ?? '',
      items: (data['items'] as List<dynamic>?)
              ?.map((item) => CartItem.fromMap(item))
              .toList() ??
          [],
      totalPrice: (data['totalPrice'] ?? 0.0).toDouble(),
      totalBonusPoints: data['totalBonusPoints'] ?? 0,
      totalBonusPointsForSubscribers: data['totalBonusPointsForSubscribers'] ?? 0,
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'items': items.map((item) => item.toMap()).toList(),
      'totalPrice': totalPrice,
      'totalBonusPoints': totalBonusPoints,
      'totalBonusPointsForSubscribers': totalBonusPointsForSubscribers,
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  Cart copyWith({
    String? id,
    String? userId,
    List<CartItem>? items,
    double? totalPrice,
    int? totalBonusPoints,
    int? totalBonusPointsForSubscribers,
    DateTime? updatedAt,
  }) {
    return Cart(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      totalPrice: totalPrice ?? this.totalPrice,
      totalBonusPoints: totalBonusPoints ?? this.totalBonusPoints,
      totalBonusPointsForSubscribers: 
          totalBonusPointsForSubscribers ?? this.totalBonusPointsForSubscribers,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
