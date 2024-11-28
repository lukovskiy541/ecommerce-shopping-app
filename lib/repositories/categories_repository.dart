// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/category_model.dart';



class CategoriesRepository {
  final FirebaseFirestore firebaseFirestore;

  CategoriesRepository({
    required this.firebaseFirestore,
  });

 
  Future<List<Category>> getCategories() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('categories').get();

    return snapshot.docs.map((doc) => Category.fromFirestore(doc)).toList();
  }

}
