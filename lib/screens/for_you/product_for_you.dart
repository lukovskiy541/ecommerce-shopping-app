import 'package:flutter/material.dart';

class ProductItemFromForYou extends StatelessWidget {
  final int size;
  final bool canBeFavorite;
  const ProductItemFromForYou(
      {super.key, required this.size, required this.canBeFavorite});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: size.toDouble(),
      width: size.toDouble() * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (canBeFavorite)
            Stack(
              children: [
                Image.asset('assets/shoe.jpg'),
                Positioned(
                  top: 1,
                  right: 5,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.favorite_border),
                  ),
                ),
              ],
            )
          else
            Image.asset('assets/shoe.jpg'),
          Text(
            '\$4 599',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              'Sketchers',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              'Черевики Hi-Ryze - I Want Thread',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                width: 15,
                height: 15,
                color: Colors.black,
              ),
              SizedBox(
                width: 7,
              ),
              Container(
                width: 15,
                height: 15,
                color: Colors.brown,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
