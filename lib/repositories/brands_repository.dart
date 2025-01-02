// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/brand_model.dart';


class BrandsRepository {
  final FirebaseFirestore firebaseFirestore;

  BrandsRepository({
    required this.firebaseFirestore,
  });

  Future<List<Brand>> getBrands() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('brands').get();
print("getting brands");
    return snapshot.docs.map((doc) => Brand.fromFirestore(doc)).toList();
  }
}
