import 'package:ecommerce_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:string_to_color/string_to_color.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/shoe.jpg',
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 1,
                right: 5,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_border),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$${product.price}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(product.brand),
                Text(
                  product.category.name,
                  style: TextStyle(color: Colors.grey),
                ),
                Row(
                  children: [
                    for (var size in product.availableSizes)
                      Padding(
                        padding: const EdgeInsets.only(right: 7),
                        child: Container(
                          width: 15,
                          height: 15,
                          child: Text(size),
                        ),
                      ),
                  ],
                ),
                Row(
                  children: [
                    for (var color in product.availableColors)
                      Padding(
                        padding: const EdgeInsets.only(right: 7),
                        child: Container(
                          width: 15,
                          height: 15,
                          color: ColorUtils.stringToColor(color),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}