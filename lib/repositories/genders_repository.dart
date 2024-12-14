// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/category_model.dart';

class GendersRepository {
  final FirebaseFirestore firebaseFirestore;

  GendersRepository({
    required this.firebaseFirestore,
  });

  Future<List<Gender>> getGenders() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('genders').get();

    return snapshot.docs.map((doc) => Gender.fromFirestore(doc)).toList();
  }
}
