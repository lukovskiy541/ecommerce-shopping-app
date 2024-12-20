import 'package:ecommerce_app/blocs/cart/cart_bloc.dart';
import 'package:ecommerce_app/blocs/profile/profile_cubit.dart';
import 'package:ecommerce_app/models/cart_item_model.dart';
import 'package:ecommerce_app/models/user_model.dart';
import 'package:ecommerce_app/screens/cart/recipient_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class OrderPlacementScreen extends StatefulWidget {
  const OrderPlacementScreen({super.key});

  @override
  State<OrderPlacementScreen> createState() => _OrderPlacementScreenState();
}

class _OrderPlacementScreenState extends State<OrderPlacementScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      User user = context.read<ProfileCubit>().state.user;
      if (user.name.isEmpty ||
          user.surname.isEmpty ||
          user.patronymic!.isEmpty ||
          user.phone.isEmpty ||
          user.addresses.isEmpty) {
        pushWithNavBar(
            context,
            MaterialPageRoute(
                builder: (context) => RecipientScreen(user: user)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
            Map<String, List<CartItem>> sellerToCartItems = {};
            state.cart.items.forEach((item) {
              String seller = item.product.seller;

              sellerToCartItems.update(
                seller,
                (existingList) => [...existingList, item],
                ifAbsent: () => [item],
              );
            });
            double full_price = List.generate(
                state.cart.items.length,
                (index) =>
                    state.cart.items[index].price *
                    state.cart.items[index].quantity).reduce((a, b) => a + b);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Оформлення',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                ),
                Text(
                  'замовлення',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                ),
                GestureDetector(
                  onTap: () => pushWithNavBar(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RecipientScreen(
                              user: context.read<ProfileCubit>().state.user))),
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Одержувач',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${context.read<ProfileCubit>().state.user.name} ${context.read<ProfileCubit>().state.user.surname} ${context.read<ProfileCubit>().state.user.patronymic}',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${context.read<ProfileCubit>().state.user.phone}',
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                          Text(
                            '${context.read<ProfileCubit>().state.user.addresses[0].city}',
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios)
                    ]),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
