// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/review_model.dart';
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
  final String street;
  final String house;
  final String? apartment;
  final String? notes;
  final bool isDefault;
  DeliveryAddress({
    required this.id,
    required this.city,
    required this.street,
    required this.house,
    this.apartment,
    this.notes,
    required this.isDefault,
  });
  factory DeliveryAddress.fromMap(Map<String, dynamic> map) {
    return DeliveryAddress(
      id: map['id'] ?? '',
      city: map['city'] ?? '',
      street: map['street'] ?? '',
      house: map['house'] ?? '',
      apartment: map['apartment'],
      notes: map['notes'],
      isDefault: map['isDefault'] ?? false,
    );
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
      topicSubscriptions: (map['topicSubscriptions'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }
}
