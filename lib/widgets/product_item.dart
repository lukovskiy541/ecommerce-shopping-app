import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/screens/product_page.dart';
import 'package:flutter/material.dart';
import 'package:string_to_color/string_to_color.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  void _imageClicked(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProductPage(product: product)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () => _imageClicked(context),
                child: Image.network(
                  product.images[0],
                  fit: BoxFit.cover,
                ),
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
          InkWell(
            onTap: () => _imageClicked(context),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$${product.price}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Text(product.brand),
                  Text(
                    product.category.name,
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      for (int i = 0;
                          i < product.availableSizes.length && i < 5;
                          i++)
                        Padding(
                          padding: const EdgeInsets.only(right: 7),
                          child: Container(
                            width: 20,
                            height: 15,
                            child: Text(product.availableSizes[i]),
                          ),
                        ),
                      if (product.availableSizes.length > 5)
                        Padding(
                          padding: const EdgeInsets.only(right: 7),
                          child: Container(
                            width: 20,
                            height: 15,
                            child: Text('...'),
                          ),
                        ),
                    ],
                  ),
                  Row(
                    children: [
                      for (var color in product.availableColors)
                        Padding(
                          padding: const EdgeInsets.only(right: 7, top: 10),
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
          ),
        ],
      ),
    );
  }
}
