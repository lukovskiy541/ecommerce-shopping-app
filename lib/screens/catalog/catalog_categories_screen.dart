import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/repositories/products_repository.dart';
import 'package:ecommerce_app/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatalogCategoryScreen extends StatefulWidget {
  final ProductType productType;
  CatalogCategoryScreen({super.key, required this.productType});

  @override
  State<CatalogCategoryScreen> createState() => _CatalogCategoryScreenState();
}

class _CatalogCategoryScreenState extends State<CatalogCategoryScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  List<Product> _products = [];
  List<Product> _filteredProducts = [];

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
    _tabController.addListener(_filterProductsByCategory);
  }

  Future<void> _initializeProducts() async {
    final products = await context.read<ProductsRepository>().getProducts();
    print('success loaded products');
    setState(() {
      _products = products;
      _filterProductsByCategory();
    });
  }

  void _filterProductsByCategory() {
    if (_tabController.indexIsChanging || _products.isEmpty) return;
    if (widget.productType.categories.isEmpty || _tabController.index < 0) {
      return;
    }
    final selectedCategory =
        widget.productType.categories[_tabController.index].name;
    setState(() {
      _filteredProducts = _products
          .where((product) => product.category.name == selectedCategory)
          .toList();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Filtered products length: ${_filteredProducts.length}');
    return Scaffold(
      appBar: AppBar(),
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
        itemCount: _filteredProducts.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          mainAxisExtent: 400
          
        ),
        itemBuilder: (context, int index) {
          return ProductItem(product: _filteredProducts[index]);
        },
      ),
    ),
  ],
)
    );
  }
}

