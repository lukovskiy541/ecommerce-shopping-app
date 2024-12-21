import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/blocs/cart/cart_bloc.dart';
import 'package:ecommerce_app/models/cart_item_model.dart';

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

  Future<Cart> addItemToCart(
      {required CartItem cartItem, required CartState currentCart}) async {
    List<CartItem> updatedCartItems = List.from(currentCart.cart.items);
    updatedCartItems.add(cartItem);

    Cart updatedCart = currentCart.cart.copyWith(items: updatedCartItems);

    if (updatedCart.id.isEmpty) {
      DocumentReference docRef = await firebaseFirestore
          .collection('carts')
          .add(updatedCart.toFirestore());
      updatedCart = updatedCart.copyWith(id: docRef.id);
    } else {
      await firebaseFirestore
          .collection('carts')
          .doc(updatedCart.id)
          .update(updatedCart.toFirestore());
    }
    return updatedCart;
  }

  Future<Cart> updateCartItems(
      {required List<CartItem> updatedItems, required CartState currentCart}) async {
    

    Cart updatedCart = currentCart.cart.copyWith(items: updatedItems);

    await firebaseFirestore
        .collection('carts')
        .doc(updatedCart.id)
        .update(updatedCart.toFirestore());
    return updatedCart;
  }

  Future<Cart> clearCart({required CartState currentCart}) async {
    Cart updatedCart = currentCart.cart.copyWith(items: []);
    await firebaseFirestore
        .collection('carts')
        .doc(updatedCart.id)
        .update(updatedCart.toFirestore());
    return updatedCart;
  }
}
