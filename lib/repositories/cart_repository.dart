import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:ecommerce_app/models/cart_model.dart';

class CartRepository {
  final FirebaseFirestore firebaseFirestore;
  CartRepository({
    required this.firebaseFirestore,
  });

  Future<Cart> getCart({required String userId}) async {
    QuerySnapshot snapshot = await firebaseFirestore
        .collection('carts')
        .where('userId', isEqualTo: userId)
        .get();

    if (snapshot.docs.isEmpty) {
      return await createCart(userId: userId);
    } else {
      return Cart.fromFirestore(snapshot.docs.first);
    }
  }

  Future<Cart> createCart({required String userId}) async {
     final newCart = Cart.initial(userId);
  DocumentReference docRef =
      await firebaseFirestore.collection('carts').add(newCart.toFirestore());
  return newCart.copyWith(id: docRef.id);
  }


}
