import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/category_model.dart';

Future<void> populateFirestore() async {
  final firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> categories = [
    {
      'name': 'Woman',
      'displayName': 'Жінкам',
      'imageUrl': 'https://example.com/shoes-category.jpg',
      'subCategories': [
        {
          'id': 'sub1',
          'name': 'Взуття',
          'imageUrl':
              'https://images.kladit.com/Ta-Ha85UDgouQ1KPNGaVd-6IP4miuSxZtSc7I7t5S3s-img_6509.jpg'
        },
        {
          'id': 'sub2',
          'name': 'Черевики та чоботи',
          'imageUrl':
              'https://images.kladit.com/Ta-Ha85UDgouQ1KPNGaVd-6IP4miuSxZtSc7I7t5S3s-img_6509.jpg'
        },
        {
          'id': 'sub3',
          'name': 'Верхній одяг',
          'imageUrl':
              'https://images.kladit.com/Ta-Ha85UDgouQ1KPNGaVd-6IP4miuSxZtSc7I7t5S3s-img_6509.jpg'
        },
        {
          'id': 'sub4',
          'name': 'Одяг',
          'imageUrl':
              'https://images.kladit.com/Ta-Ha85UDgouQ1KPNGaVd-6IP4miuSxZtSc7I7t5S3s-img_6509.jpg'
        },
        {
          'id': 'sub5',
          'name': 'Кросівки та кеди',
          'imageUrl':
              'https://images.kladit.com/Ta-Ha85UDgouQ1KPNGaVd-6IP4miuSxZtSc7I7t5S3s-img_6509.jpg'
        },
        {
          'id': 'sub6',
          'name': 'Кофти та светри',
          'imageUrl':
              'https://images.kladit.com/Ta-Ha85UDgouQ1KPNGaVd-6IP4miuSxZtSc7I7t5S3s-img_6509.jpg'
        },
        {
          'id': 'sub7',
          'name': 'Аксесуари',
          'imageUrl':
              'https://images.kladit.com/Ta-Ha85UDgouQ1KPNGaVd-6IP4miuSxZtSc7I7t5S3s-img_6509.jpg'
        },
        {
          'id': 'sub8',
          'name': 'Джинси та штани',
          'imageUrl':
              'https://images.kladit.com/Ta-Ha85UDgouQ1KPNGaVd-6IP4miuSxZtSc7I7t5S3s-img_6509.jpg'
        },
        {
          'id': 'sub9',
          'name': 'Косметика',
          'imageUrl':
              'https://images.kladit.com/Ta-Ha85UDgouQ1KPNGaVd-6IP4miuSxZtSc7I7t5S3s-img_6509.jpg'
        },
        {
          'id': 'sub10',
          'name': 'Сумки',
          'imageUrl':
              'https://images.kladit.com/Ta-Ha85UDgouQ1KPNGaVd-6IP4miuSxZtSc7I7t5S3s-img_6509.jpg'
        },
      ],
    },
  ];

  List<Category> categorys = [];

  for (var category in categories) {
    DocumentReference categoryRef =
        await firestore.collection('categories').add({
      'name': category['name'],
      'displayName': category['displayName'],
      'imageUrl': category['imageUrl'],
      'subCategories': category['subCategories'],
    });

    List<SubCategory> subCategories = (category['subCategories'] as List)
        .map((subCategory) => SubCategory.fromMap(subCategory))
        .toList();

    categorys.add(Category(
      id: categoryRef.id,
      name: category['name'],
      imageUrl: category['imageUrl'],
      subCategories: subCategories,
    ));
  }

  await firestore.collection('products').add({
    'name': 'Nike Air Max',
    'description': 'Comfortable running shoes',
    'price': 2999.0,
    'imageUrl': 'https://example.com/nike-air-max.jpg',
    'category': categorys[0].toJson(),
    'subCategory': categorys[0].subCategories[0].toJson(),
    'availableSizes': ['40', '41', '42', '43'],
    'availableColors': ['Black', 'White', 'Red'],
    'bonusPoints': 50,
    'bonusPointsForSubscribers': 75,
    'brand': 'Nike',
    'seller': 'Nike Official Store',
    'stock': 100,
  });

  print('Categories and products uploaded successfully');
}