// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String surname;
  final String? patronymic;
  final bool sex;
  final DateTime birthday;
  final String phone;
 

  final int bonusPoints;
  final String cardLevel;
  final bool hasSubscription;

  final List<DeliveryAddress> addresses;

  final String? shoeSize;
  final String? clothingSize;

  final List<String> favoriteCategories;
  final List<String> favoriteProducts;

  final List<dynamic> orderHistory;
  final List<Review> reviews;

  final String? preferredLanguage;
  final NotificationSettings notificationSettings;

  final DateTime createdAt;
  final DateTime lastLogin;

  factory User.initial() {
    return User(
      id: '',
      email: '',
      name: '',
      surname: '',
      patronymic: null,
      sex: false,
      birthday: DateTime.now(),
      phone: '',
      bonusPoints: 0,
      cardLevel: 'Base',
      hasSubscription: false,
      addresses: [],
      shoeSize: null,
      clothingSize: null,
      favoriteCategories: [],
      favoriteProducts: [],
      orderHistory: [],
      reviews: [],
      preferredLanguage: null,
      notificationSettings: NotificationSettings(
        pushEnabled: true,
        emailEnabled: true,
        smsEnabled: true,
        topicSubscriptions: [],
      ),
      createdAt: DateTime.now(),
      lastLogin: DateTime.now(),
    );
  }

  factory User.fromDoc(DocumentSnapshot userDoc) {
    final userData = userDoc.data() as Map<String, dynamic>?;

    return User(
      id: userDoc.id,
      email: userData?['email'] ?? '',
      name: userData?['name'] ?? '',
      surname: userData?['surname'] ?? '',
      patronymic: userData?['patronymic'],
      sex: userData?['sex'] ?? false,
      birthday:
          (userData?['birthday'] as Timestamp?)?.toDate() ?? DateTime.now(),
      phone: userData?['phone'] ?? '',
      bonusPoints: userData?['bonusPoints'] ?? 0,
      cardLevel: userData?['cardLevel'] ?? 'Base',
      hasSubscription: userData?['hasSubscription'] ?? false,
      addresses: (userData?['addresses'] as List<dynamic>?)
              ?.map((address) =>
                  DeliveryAddress.fromMap(address as Map<String, dynamic>))
              .toList() ??
          [],
      shoeSize: userData?['shoeSize'],
      clothingSize: userData?['clothingSize'],
      favoriteCategories: (userData?['favoriteCategories'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      favoriteProducts: (userData?['favoriteProducts'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      orderHistory: (userData?['orderHistory'] as List<dynamic>?)
              ?.map(
                  (order) => order.Order.fromMap(order as Map<String, dynamic>))
              .toList() ??
          [],
      reviews: (userData?['reviews'] as List<dynamic>?)
              ?.map((review) => Review.fromMap(review as Map<String, dynamic>))
              .toList() ??
          [],
      preferredLanguage: userData?['preferredLanguage'],
      notificationSettings: userData?['notificationSettings'] != null
          ? NotificationSettings.fromMap(
              userData!['notificationSettings'] as Map<String, dynamic>)
          : NotificationSettings(
              pushEnabled: true,
              emailEnabled: true,
              smsEnabled: true,
              topicSubscriptions: [],
            ),
      createdAt:
          (userData?['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      lastLogin:
          (userData?['lastLogin'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.surname,
    this.patronymic,
    required this.sex,
    required this.birthday,
    required this.phone,
    required this.bonusPoints,
    required this.cardLevel,
    required this.hasSubscription,
    required this.addresses,
    this.shoeSize,
    this.clothingSize,
    required this.favoriteCategories,
    required this.favoriteProducts,
    required this.orderHistory,
    required this.reviews,
    this.preferredLanguage,
    required this.notificationSettings,
    required this.createdAt,
    required this.lastLogin,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      surname: map['surname'] ?? '',
      patronymic: map['patronymic'],
      sex: map['sex'] ?? false,
      birthday: (map['birthday'] as Timestamp?)?.toDate() ?? DateTime.now(),
      phone: map['phone'] ?? '',
      bonusPoints: map['bonusPoints'] ?? 0,
      cardLevel: map['cardLevel'] ?? 'Base',
      hasSubscription: map['hasSubscription'] ?? false,
      addresses: (map['addresses'] as List<dynamic>?)
              ?.map((address) =>
                  DeliveryAddress.fromMap(address as Map<String, dynamic>))
              .toList() ??
          [],
      shoeSize: map['shoeSize'],
      clothingSize: map['clothingSize'],
      favoriteCategories: (map['favoriteCategories'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      favoriteProducts: (map['favoriteProducts'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      orderHistory: map['orderHistory'] ?? [],
      reviews: (map['reviews'] as List<dynamic>?)
              ?.map((review) => Review.fromMap(review as Map<String, dynamic>))
              .toList() ??
          [],
      preferredLanguage: map['preferredLanguage'],
      notificationSettings: NotificationSettings.fromMap(
          map['notificationSettings'] as Map<String, dynamic>),
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      lastLogin: (map['lastLogin'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'surname': surname,
      'patronymic': patronymic,
      'sex': sex,
      'birthday': birthday,
      'phone': phone,
      'bonusPoints': bonusPoints,
      'cardLevel': cardLevel,
      'hasSubscription': hasSubscription,
      'addresses': addresses.map((address) => address.toMap()).toList(),
      'shoeSize': shoeSize,
      'clothingSize': clothingSize,
      'favoriteCategories': favoriteCategories,
      'favoriteProducts': favoriteProducts,
      'orderHistory': orderHistory,
      'reviews': reviews.map((review) => review.toMap()).toList(),
      'preferredLanguage': preferredLanguage,
      'notificationSettings': notificationSettings.toMap(),
      'createdAt': createdAt,
      'lastLogin': lastLogin,
    };
  }

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? surname,
    String? patronymic,
    bool? sex,
    DateTime? birthday,
    String? phone,
    int? bonusPoints,
    String? cardLevel,
    bool? hasSubscription,
    List<DeliveryAddress>? addresses,
    String? shoeSize,
    String? clothingSize,
    List<String>? favoriteCategories,
    List<String>? favoriteProducts,
    List<dynamic>? orderHistory,
    List<Review>? reviews,
    String? preferredLanguage,
    NotificationSettings? notificationSettings,
    DateTime? createdAt,
    DateTime? lastLogin,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      patronymic: patronymic ?? this.patronymic,
      sex: sex ?? this.sex,
      birthday: birthday ?? this.birthday,
      phone: phone ?? this.phone,
      bonusPoints: bonusPoints ?? this.bonusPoints,
      cardLevel: cardLevel ?? this.cardLevel,
      hasSubscription: hasSubscription ?? this.hasSubscription,
      addresses: addresses ?? this.addresses,
      shoeSize: shoeSize ?? this.shoeSize,
      clothingSize: clothingSize ?? this.clothingSize,
      favoriteCategories: favoriteCategories ?? this.favoriteCategories,
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
      orderHistory: orderHistory ?? this.orderHistory,
      reviews: reviews ?? this.reviews,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      notificationSettings: notificationSettings ?? this.notificationSettings,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      email,
      name,
      surname,
      patronymic!,
      sex,
      birthday,
      phone,
      bonusPoints,
      cardLevel,
      hasSubscription,
      addresses,
      shoeSize!,
      clothingSize!,
      favoriteCategories,
      favoriteProducts,
      orderHistory,
      reviews,
      preferredLanguage!,
      notificationSettings,
      createdAt,
      lastLogin,
    ];
  }

  @override
  String toString() {
    return 'User{id=$id, email=$email, name=$name, surname=$surname, patronymic=$patronymic, sex=$sex, birthday=$birthday, phone=$phone, bonusPoints=$bonusPoints, cardLevel=$cardLevel, hasSubscription=$hasSubscription, addresses=$addresses, shoeSize=$shoeSize, clothingSize=$clothingSize, favoriteCategories=$favoriteCategories, favoriteProducts=$favoriteProducts, orderHistory=$orderHistory, reviews=$reviews, preferredLanguage=$preferredLanguage, notificationSettings=$notificationSettings, createdAt=$createdAt, lastLogin=$lastLogin}';
  }
}

class DeliveryAddress {
  final String id;
  final String city;


  DeliveryAddress({
    required this.id,
    required this.city,

  });

  factory DeliveryAddress.fromMap(Map<String, dynamic> map) {
    return DeliveryAddress(
      id: map['id'] ?? '',
      city: map['city'] ?? '',
     
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'city': city,
   
    };
  }
}

class NotificationSettings {
  final bool pushEnabled;
  final bool emailEnabled;
  final bool smsEnabled;
  final List<String> topicSubscriptions;

  NotificationSettings({
    required this.pushEnabled,
    required this.emailEnabled,
    required this.smsEnabled,
    required this.topicSubscriptions,
  });

  factory NotificationSettings.fromMap(Map<String, dynamic> map) {
    return NotificationSettings(
      pushEnabled: map['pushEnabled'] ?? true,
      emailEnabled: map['emailEnabled'] ?? true,
      smsEnabled: map['smsEnabled'] ?? true,
      topicSubscriptions:
          List<String>.from(map['topicSubscriptions'] ?? const []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pushEnabled': pushEnabled,
      'emailEnabled': emailEnabled,
      'smsEnabled': smsEnabled,
      'topicSubscriptions': topicSubscriptions,
    };
  }
}

class Review {
  final String userId;
  final String productId;
  final String reviewText;
  final double rating;

  Review({
    required this.userId,
    required this.productId,
    required this.reviewText,
    required this.rating,
  });

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      userId: map['userId'] ?? '',
      productId: map['productId'] ?? '',
      reviewText: map['reviewText'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'productId': productId,
      'reviewText': reviewText,
      'rating': rating,
    };
  }
}
