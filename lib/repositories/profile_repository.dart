import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants/db_constants.dart';
import 'package:ecommerce_app/models/custom_error.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/models/user_model.dart';

class ProfileRepository {
  final FirebaseFirestore firebaseFirestore;
  const ProfileRepository({
    required this.firebaseFirestore,
  });

  Future<User> updateProfile({required User user}) async {
  try {
    await firebaseFirestore.collection('users').doc(user.id).update({
      'email': user.email,
      'name': user.name,
      'surname': user.surname,
      'patronymic': user.patronymic,
      'sex': user.sex,
      'birthday': user.birthday,
      'phone': user.phone,
      'bonusPoints': user.bonusPoints,
      'cardLevel': user.cardLevel,
      'hasSubscription': user.hasSubscription,
      'addresses': user.addresses.map((e) => e.toMap()).toList(),
      'shoeSize': user.shoeSize,
      'clothingSize': user.clothingSize,
      'favoriteCategories': user.favoriteCategories,
      'favoriteProducts': user.favoriteProducts,
      'orderHistory': user.orderHistory,
      'reviews': user.reviews.map((e) => e.toMap()).toList(),
      'preferredLanguage': user.preferredLanguage,
      'notificationSettings': user.notificationSettings.toMap(),
      'createdAt': user.createdAt,
      'lastLogin': user.lastLogin,
    });

    return user;
  } catch (e) {
    throw CustomError(message: 'Failed to update profile');
  }
}

  Future<User> toggleFavoriteProduct({
    required User user,
    required Product product,
  }) async {
    try {
      final updatedFavoriteProducts = List<String>.from(user.favoriteProducts);
      if (updatedFavoriteProducts.contains(product.id)) {
        updatedFavoriteProducts.remove(product.id);
      } else {
        updatedFavoriteProducts.add(product.id);
      }
      

      await firebaseFirestore.collection('users').doc(user.id).update({
        'favoriteProducts': updatedFavoriteProducts,
      });

      return user.copyWith(favoriteProducts: updatedFavoriteProducts);
    } catch (e) {
      throw CustomError(message: 'Failed to add favorite product');
    }
  }

  Future<User> getProfile({required String uid}) async {
    try {
      final DocumentSnapshot userDoc = await userRef.doc(uid).get();

      if (userDoc.exists) {
        final currentUser = User.fromDoc(userDoc);
        return currentUser;
      }

      throw 'User not found';
    } on FirebaseException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  clearfavorites({required User user}) async {
    try {
      await firebaseFirestore.collection('users').doc(user.id).update({
        'favoriteProducts': [],
      });

      return user.copyWith(favoriteProducts: []);
    } catch (e) {
      throw CustomError(message: 'Failed to clear favorites');
    }
  }
}
