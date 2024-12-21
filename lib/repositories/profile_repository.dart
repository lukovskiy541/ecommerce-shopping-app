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
        'name': user.name,
        'surname': user.surname,
        'patronymic': user.patronymic,
        'phone': user.phone,
        'addresses': user.addresses.map((e) => e.toMap()).toList(),
      });

      return user;
    } catch (e) {
      throw CustomError(message: 'Failed to update profile');
    }
  }

  Future<User> addFavoriteProduct({
    required User user,
    required Product product,
  }) async {
    try {
      final updatedFavoriteProducts = List<String>.from(user.favoriteProducts);
      updatedFavoriteProducts.add(product.id);

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

  
}
