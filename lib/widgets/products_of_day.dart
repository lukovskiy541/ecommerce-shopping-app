import 'package:ecommerce_app/widgets/product.dart';

import 'package:flutter/material.dart';


class ProductsOfDay extends StatelessWidget {
  const ProductsOfDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                      'Товар дня',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
                    ),
                  
                  Text(
                      'Встигни придбати',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                child: Row(
                  children: [
                    Icon(Icons.timer_outlined, color: Colors.red,),
                    Text('21:40:07', style: TextStyle(color: Colors.red),)
                  ],
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 630, 
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ProductItem(size: 600, canBeFavorite: false,),
              );
            },
          ),
        ),
        
      ],
    );
  }
}
