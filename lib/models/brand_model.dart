import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Brand {
  final String name;
  final String imageUrl;

  Brand({required this.name, required this.imageUrl});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  factory Brand.fromMap(Map<String, dynamic> map) {
    return Brand(
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Brand.fromJson(String source) =>
      Brand.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Brand.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Brand(
      name: data['name'] as String,
      imageUrl: data['imageUrl'] as String,
    );
  }
}
