import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/product_model.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Product>> getProducts() async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('products')
      .get();
  
  return snapshot.docs.map((doc) => 
    Product.fromFirestore(doc)
  ).toList();
}
}