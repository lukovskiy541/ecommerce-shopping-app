import 'package:ecommerce_app/blocs/cart/cart_bloc.dart';
import 'package:ecommerce_app/models/cart_item_model.dart';
import 'package:ecommerce_app/screens/bucket_screen.dart';
import 'package:ecommerce_app/widgets/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state.status == CartStatus.loaded) {
          if (state.cart.items.isEmpty) {
            return FullscreenBackgroundImage();
          } else {
            Map<String, List<CartItem>> sellerToCartItems = {};
            state.cart.items.forEach((item) {
              String seller = item.product.seller;

              sellerToCartItems.update(
                seller,
                (existingList) => [...existingList, item],
                ifAbsent: () => [item],
              );
            });
            double full_price = List.generate(state.cart.items.length,
                    (index) => state.cart.items[index].price)
                .reduce((a, b) => a + b);
            return SafeArea(
              child: Scaffold(
                  floatingActionButton: SizedBox(
            width: 390,
            height: 50,
            child: FloatingActionButton.extended(
              onPressed: () {
                
                
              },
              label: Text(
                'Оформити замовлення',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              backgroundColor: Colors.black,
              elevation: 0,
              highlightElevation: 0,
            ),
          ),
                backgroundColor: Colors.grey.shade200,
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Очистити',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 10,
                                right: 10,
                              ),
                              child: Text(
                                'Кошик',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                ),
                              ),
                            ),
                            for (var seller in sellerToCartItems.keys)
                              CartCard(
                                CartItems: sellerToCartItems[seller]!,
                                seller: seller,
                              ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20, bottom: 80),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Разом:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 30),
                                  ),
                                  Text('\$ ${full_price}')
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
