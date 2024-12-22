import 'package:ecommerce_app/blocs/cart/cart_bloc.dart';
import 'package:ecommerce_app/blocs/profile/profile_cubit.dart';
import 'package:ecommerce_app/models/order_model.dart';
import 'package:ecommerce_app/models/user_model.dart';
import 'package:ecommerce_app/screens/cart/delivery_screen.dart';
import 'package:ecommerce_app/screens/cart/order_success_screen.dart';
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
  bool _isDeliverySelected = false;
  String _postDepartment = '';

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
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, profileState) {
        return BlocBuilder<CartBloc, CartState>(
          builder: (context, cartState) {
            double full_price = List.generate(
  cartState.cart.items.length,
  (index) =>
      cartState.cart.items[index].price *
      cartState.cart.items[index].quantity,
).fold(0, (a, b) => a + b);

            return Scaffold(
              appBar: AppBar(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                height: 50,
                child: FloatingActionButton.extended(
                  onPressed: () async {
                    if (_isDeliverySelected) {
                            print('recieved');
                            Order order = Order(
                              id: '',
                              userId: profileState.user.id,
                              status: OrderStatus.processing,
                              items: cartState.cart.items,
                              deliveryAdress: _postDepartment,
                              createdAt: DateTime.now(),
                              subtotal: full_price,
                              deliveryCost: 11,
                              discount: 0,
                              bonusesUsed: 0,
                              bonusesEarned: 0,
                              total: full_price + 11,
                              isGift: false,
                            );
                            bool result = await context
                                .read<ProfileCubit>()
                                .addOrder(order: order);
                            if (result) {
                               pushWithNavBar(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          OrderSuccessScreen()));
                              context.read<CartBloc>().add(CartClearEvent());
                             
                            }
                          }
                  }
                     
                  ,
                  label: Text(
                    'Оформити замовлення',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  backgroundColor:
                      _isDeliverySelected ? Colors.black : Colors.grey.shade300,
                  elevation: 0,
                  highlightElevation: 0,
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Оформлення',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40),
                      ),
                      Text(
                        'замовлення',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40),
                      ),
                      GestureDetector(
                        onTap: () => pushWithNavBar(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RecipientScreen(
                                    user: context
                                        .read<ProfileCubit>()
                                        .state
                                        .user))),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
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
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.grey),
                                    ),
                                    Text(
                                      '${context.read<ProfileCubit>().state.user.addresses[0].city}',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios)
                              ]),
                        ),
                      ),
                      SizedBox(height: 40),
                      Padding(
                          padding: EdgeInsets.only(left: 0),
                          child: Text(
                            'Відділення',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () async {
                          String postDepartment = await pushWithNavBar(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DeliveryScreen()));

                          setState(() {
                            _postDepartment = postDepartment;
                            _isDeliverySelected = true;
                          });
                        },
                        child: Container(
                            width: double.infinity,
                            height: 150,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Нова пошта',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          _isDeliverySelected
                                              ? _postDepartment
                                              : '\$11',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Text('тариф перевізника'),
                                        ),
                                        Icon(Icons.arrow_forward_ios)
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )),
                      ),
                      SizedBox(height: 40),
                      Padding(
                        padding: EdgeInsets.only(left: 0),
                        child: Row(children: [
                          Text(
                            'Разом',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '\$ ${full_price + 11}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          )
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
