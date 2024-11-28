import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  Review({
    required this.id,
    required this.productId,
    required this.userId,
    required this.rating,
    required this.comment,
    required this.isVerifiedPurchase,
    required this.createdAt,
    required this.likesCount,
    required this.isModerated,
    this.photos,
    this.detailedRatings,
    this.size,
    this.fitsAsExpected,
    this.moderatorNote,
    this.moderatedAt,
    this.brandResponse,
    this.brandResponseDate
  });
  final String id;
  final String productId;
  final String userId;
  final double rating;
  final String comment;
  final List<String>? photos;
  final bool isVerifiedPurchase;
  final DateTime createdAt;
  final int likesCount;
  final bool isModerated;
  
  final Map<String, int>? detailedRatings;
  final String? size;
  final bool? fitsAsExpected;
  
  final String? moderatorNote;
  final DateTime? moderatedAt;
  
  final String? brandResponse;
  final DateTime? brandResponseDate;

   factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'] ?? '',
      productId: map['productId'] ?? '',
      userId: map['userId'] ?? '',
      rating: (map['rating'] ?? 0).toDouble(),
      comment: map['comment'] ?? '',
      photos: (map['photos'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      isVerifiedPurchase: map['isVerifiedPurchase'] ?? false,
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      likesCount: map['likesCount'] ?? 0,
      isModerated: map['isModerated'] ?? false,
      detailedRatings: (map['detailedRatings'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(key, value as int),
      ),
      size: map['size'],
      fitsAsExpected: map['fitsAsExpected'],
      moderatorNote: map['moderatorNote'],
      moderatedAt: (map['moderatedAt'] as Timestamp?)?.toDate(),
      brandResponse: map['brandResponse'],
      brandResponseDate: (map['brandResponseDate'] as Timestamp?)?.toDate(),
    );
  }
}
