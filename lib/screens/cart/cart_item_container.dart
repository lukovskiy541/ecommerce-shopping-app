import 'package:ecommerce_app/blocs/cart/cart_bloc.dart';
import 'package:ecommerce_app/models/cart_item_model.dart';

import 'package:ecommerce_app/screens/cart/change_quantity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CartItemContainer extends StatelessWidget {
  const CartItemContainer(
      {super.key, required this.item, required this.withButton});

  final CartItem item;
  final bool withButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    if (withButton)
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height * 0.4,
                                ),
                                builder: (bottomSheetContext) => Center(
                                      child: ListView(
                                        children: [
                                          ListTile(
                                            title: Center(
                                                child: Text('Доступні дії',
                                                    style: TextStyle(
                                                        color: Colors.grey))),
                                          ),
                                          Divider(
                                              height: 1,
                                              color: Colors.grey[300]),
                                          ListTile(
                                            onTap: () async {
                                              final parentContext = context;
                                              Navigator.pop(bottomSheetContext);
                                              final newQuantity =
                                                  await pushScreenWithNavBar(
                                                      parentContext,
                                                      ChangeQuantityScreen(
                                                          cartItem: item));

                                              if (newQuantity != null) {
                                                parentContext
                                                    .read<CartBloc>()
                                                    .add(
                                                      CartUpdateItemQuantityEvent(
                                                        productId:
                                                            item.product.id,
                                                        quantity: newQuantity -
                                                            item.quantity,
                                                        selectedSize:
                                                            item.selectedSize,
                                                      ),
                                                    );
                                              }
                                            },
                                            title: Center(
                                                child: Text(
                                              'Змінити кількість',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue),
                                            )),
                                          ),
                                          Divider(
                                              height: 1,
                                              color: Colors.grey[300]),
                                          ListTile(
                                            title: Center(
                                                child: Text(
                                              'До списку бажань',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue),
                                            )),
                                          ),
                                          Divider(
                                              height: 1,
                                              color: Colors.grey[300]),
                                          ListTile(
                                            title: Center(
                                                child: Text('Видалити',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.red))),
                                          ),
                                          ListTile(
                                            onTap: () => Navigator.pop(bottomSheetContext),
                                            title: Center(
                                              child: Text('Закрити'),
                                            ),
                                          ),
                                          Divider(
                                              height: 1,
                                              color: Colors.grey[300]),
                                        ],
                                      ),
                                    ));
                          },
                          icon: Icon(Icons.more_horiz))
                  ],
                ),
                Text(
                  item.product.brand,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                          Text('${item.quantity}')
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
    );
  }
}
