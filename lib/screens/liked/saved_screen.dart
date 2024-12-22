import 'package:ecommerce_app/blocs/products/products_bloc.dart';
import 'package:ecommerce_app/blocs/profile/profile_cubit.dart';
import 'package:ecommerce_app/models/product_model.dart';

import 'package:ecommerce_app/screens/catalog/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    final productsState = context.read<ProductsBloc>().state;
    final profileState = context.read<ProfileCubit>().state;
    _updateProducts(productsState, profileState);
  }

  void _updateProducts(ProductsState productsState, ProfileState profileState) {
    final productsId = profileState.user.favoriteProducts;
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
      
            _updateProducts(productsState, context.read<ProfileCubit>().state);
          },
        ),
        BlocListener<ProfileCubit, ProfileState>(
                    listenWhen: (previous, current) => 
            previous.user.favoriteProducts != current.user.favoriteProducts,
          listener: (context, profileState) {
            _updateProducts(context.read<ProductsBloc>().state, profileState);
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            TextButton(
              child: const Text('Очистити'),
              onPressed: () {
                context.read<ProfileCubit>().clearFavorites();
              },
            ),
          ],
        ),
        body:Column(
          
          children: [
            Container(
              width: double.infinity,
              height: 200,
              margin: const EdgeInsets.only(top: 45.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/saved.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
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
              child: const Center(child: Text('Немає збережених товарів')),
            ),
          ],
        ) ,
      ),
    );
  }
}
