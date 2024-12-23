import 'package:ecommerce_app/blocs/products/products_bloc.dart';
import 'package:ecommerce_app/blocs/profile/profile_cubit.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/screens/catalog/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserOrdersHistory extends StatefulWidget {
  UserOrdersHistory({super.key});

  @override
  State<UserOrdersHistory> createState() => _UserOrdersHistoryState();
}

class _UserOrdersHistoryState extends State<UserOrdersHistory> {
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    final productsState = context.read<ProductsBloc>().state;
    final profileState = context.read<ProfileCubit>().state;
    _updateProducts(productsState, profileState);
  }

  void _updateProducts(ProductsState productsState, ProfileState profileState) {
    final productsId = profileState.user.orderHistory;
    setState(() {
      _products = productsState.products
          .where((product) => productsId.contains(product.id))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<ProductsBloc, ProductsState>(
            listenWhen: (previous, current) =>
                previous.products != current.products,
            listener: (context, productsState) {
              _updateProducts(
                  productsState, context.read<ProfileCubit>().state);
            },
          ),
          BlocListener<ProfileCubit, ProfileState>(
            listenWhen: (previous, current) =>
                previous.user.orderHistory != current.user.orderHistory,
            listener: (context, profileState) {
              _updateProducts(context.read<ProductsBloc>().state, profileState);
            },
          ),
        ],
        child: Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Мої покупки',
                      style:
                          TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                   _products.isNotEmpty ?  Expanded(
              child: Container(
                color: Colors.white,
                child: GridView.builder(
                  itemCount: _products.length,
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    mainAxisExtent: 388,
                  ),
                  itemBuilder: (context, int index) {
                    return ProductItem(product: _products[index]);
                  },
                ),
              ) ,
            ): Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: const Center(child: Text('Ви ще не робили покупок')),
            ),
                ],
              ),
            )));
  }
}
