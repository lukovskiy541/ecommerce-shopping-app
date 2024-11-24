// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants/db_constants.dart';
import 'package:ecommerce_app/models/custom_error.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

class AuthRepository {
  final FirebaseFirestore firebaseFirestore;
  final fbAuth.FirebaseAuth firebaseAuth;
  AuthRepository({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  Stream<fbAuth.User?> get user => firebaseAuth.userChanges();

  Future<void> signup({
  required String email,
  required String password,
}) async {
  try {
    final fbAuth.UserCredential userCredential =
        await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final signedInUser = userCredential.user!;
    final now = DateTime.now();

    await userRef.doc(signedInUser.uid).set({
      'id': signedInUser.uid,
      'email': email,
      'name': '',
      'surname': '',
      'patronymic': null,
      'sex': false,
      'birthday': now,
      'phone': '',
      
      'bonusPoints': 0,
      'cardLevel': 'Base',
      'hasSubscription': false,
      
      'addresses': [],
      
      'shoeSize': null,
      'clothingSize': null,
      
      'favoriteCategories': [],
      'favoriteProducts': [],
      
      'orderHistory': [],
      'reviews': [],
      
      'preferredLanguage': null,
      'notificationSettings': {
        'pushEnabled': true,
        'emailEnabled': true,
        'smsEnabled': true,
        'topicSubscriptions': [],
      },
      
      'createdAt': now,
      'lastLogin': now,
    });
  } on fbAuth.FirebaseAuthException catch (e) {
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

Future<void> signin({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on fbAuth.FirebaseAuthException catch (e) {
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
  
  Future<void> signout() async {
    await firebaseAuth.signOut();
  }
}
