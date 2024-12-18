import 'package:flutter/material.dart';
import 'package:ecommerce_app/models/cart_item_model.dart';

class CartCard extends StatefulWidget {
  final List<CartItem> CartItems;
  final String seller;
  const CartCard({
    Key? key,
    required this.CartItems,
    required this.seller,
  }) : super(key: key);

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    
    return Container(
      color: Colors.white,
      width: double.infinity,

      child: Padding(
        padding: EdgeInsets.only(left: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.seller,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    Text(
                      'продавець',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.close))
              ],
            ),
            for (var item in widget.CartItems)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      item.product.images[0],
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${item.product.price} грн',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.more_horiz))
                            ],
                          ),
                          Text(
                            item.product.brand,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${item.product.category.name} ${item.product.name}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Text('Розмір:'), Text('Кількість:')],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.selectedSize),
                                    Text('${item.quantity} штука')
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            
          ],
        ),
      ),
    );
  }
}
