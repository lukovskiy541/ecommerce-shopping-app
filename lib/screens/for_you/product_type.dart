import 'package:flutter/material.dart';

class ProductType extends StatelessWidget {
  const ProductType({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 150,
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/shoe.jpg'),
                fit: BoxFit.cover, 
              ),
            ),
          ),
          Text(
            'Черевики',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              'всі можливі',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          
        ],
      ),
    );
  }
}
