// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ecommerce_app/models/product_model.dart';

class ProductsRepository {
  final FirebaseFirestore firebaseFirestore;

  ProductsRepository({
    required this.firebaseFirestore,
  });

 

  Future<List<Product>> getProducts() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('products').get();

    return snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
  }


  Future<void> updateProduct(Product product) async {
    try {
      await firebaseFirestore.collection('products')
        .doc(product.id)
        .update(product.toFirestore());
    } catch (e) {
      print('Error updating product: $e');
      rethrow;
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await firebaseFirestore.collection('products').doc(productId).delete();
    } catch (e) {
      print('Error deleting product: $e');
      rethrow;
    }
  }
}
