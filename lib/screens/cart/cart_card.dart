import 'package:ecommerce_app/blocs/cart/cart_bloc.dart';
import 'package:ecommerce_app/screens/cart/cart_item_container.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/models/cart_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CartCard extends StatefulWidget {
  final List<CartItem> CartItems;
  final String seller;
  CartCard({
    Key? key,
    required this.CartItems,
    required this.seller,
  }) : super(key: key);

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  Future<bool?> _showConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Видалити всі товари продавця ${widget.seller} ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Ні'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Так'),
            ),
          ],
        );
      },
    );
  }

  void _handleUserResponse(BuildContext context) async {
    final bool? result = await _showConfirmationDialog(context);
    if (result == true) {
      context.read<CartBloc>().add(CartRemoveSellerItemsEvent(widget.seller));
    }
  }

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
                IconButton(
                    onPressed: () {
                      _handleUserResponse(context);
                    },
                    icon: Icon(Icons.close))
              ],
            ),
            for (var item in widget.CartItems)
              CartItemContainer(item: item, withButton: true),
          ],
        ),
      ),
    );
  }
}

