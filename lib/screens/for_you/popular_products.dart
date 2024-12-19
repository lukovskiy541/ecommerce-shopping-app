import 'package:ecommerce_app/screens/for_you/product_for_you.dart';
import 'package:ecommerce_app/screens/for_you/product_type.dart';
import 'package:flutter/material.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Популярні товари',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 330, // Визначає висоту
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ProductItemFromForYou(
                  size: 250,
                  canBeFavorite: true,
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 250, // Визначає висоту
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ProductType(),
              );
            },
          ),
        ),
      ],
    );
  }
}
