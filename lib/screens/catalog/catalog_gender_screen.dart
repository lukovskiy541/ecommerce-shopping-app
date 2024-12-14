import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/repositories/products_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatalogCategoryScreen extends StatefulWidget {
  ProductType productType;
  CatalogCategoryScreen({super.key, required this.productType});

  @override
  State<CatalogCategoryScreen> createState() => _CatalogCategoryScreenState();
}

class _CatalogCategoryScreenState extends State<CatalogCategoryScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  List<Product> _products = [];
  @override
  void initState() {
    super.initState();
    _initTabs();
  }

  void _initTabs() async {
    await _initializeTabController();
    await _initializeProducts();
  }

  Future<void> _initializeTabController() async {
    setState(() {
      _tabController = TabController(
        length: widget.productType.categories.length,
        vsync: this,
      );
    });
  }

  Future<void> _initializeProducts() async {
    final products = await context.watch<ProductsRepository>().getProducts();
    print('success loaded products');
    setState(() {
      _products = products;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('products length ${_products.length}');
    return Scaffold(
      body: Column(
        children: [
          Text(
            widget.productType.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          Row(
            children: [
              Icon(Icons.woman),
              Icon(Icons.woman),
              Icon(Icons.woman),
              Icon(Icons.woman),
              Spacer(),
              Icon(Icons.settings),
            ],
          ),
          TabBar.secondary(
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            indicatorPadding: EdgeInsets.zero,
            controller: _tabController,
            padding: EdgeInsets.zero,
            tabs: widget.productType.categories
                .map((category) => Tab(
                      text: category.name,
                    ))
                .toList(),
          ),
          Expanded(
            child: GridView.builder(
                itemCount: _products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, int index) {
                  return Container(
                    child: Text(
                      _products[index].name,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
