import 'package:ecommerce_app/blocs/products/products_bloc.dart';
import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/models/product_model.dart';

import 'package:ecommerce_app/screens/catalog/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatalogCategoryScreen extends StatefulWidget {
  final ProductType productType;
  final Gender gender;
  CatalogCategoryScreen(
      {super.key, required this.productType, required this.gender});

  @override
  State<CatalogCategoryScreen> createState() => _CatalogCategoryScreenState();
}

class _CatalogCategoryScreenState extends State<CatalogCategoryScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  late final AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeController.forward();

    _initTabs();
  }

  void _initTabs() async {
    await _initializeTabController();
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
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Filtered products length: ${_filteredProducts.length}');
    return BlocListener<ProductsBloc, ProductsState>(
        listener: (context, state) {
          if (state.status == ProductsStatus.loaded) {
            setState(() {
              _products = state.products;
              _filterProductsByCategory();
            });
          }
        },
        child: Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Text(
                  widget.productType.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.woman,
                      color: widget.gender.name == "Жінкам"
                          ? Colors.green.shade300
                          : Colors.black,
                    ),
                    Icon(
                      Icons.man,
                      color: widget.gender.name == "Чоловікам"
                          ? Colors.green.shade300
                          : Colors.black,
                    ),
                    Icon(
                      Icons.boy,
                      color: widget.gender.name == "Дівчаткам"
                          ? Colors.green.shade300
                          : Colors.black,
                    ),
                    Icon(
                      Icons.girl,
                      color: widget.gender.name == "Хлопчикам"
                          ? Colors.green.shade300
                          : Colors.black,
                    ),
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
                  child: FadeTransition(
                    opacity: _fadeController,
                    child: GridView.builder(
                      itemCount: _filteredProducts.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          mainAxisExtent: 450),
                      itemBuilder: (context, int index) {
                        return ProductItem(product: _filteredProducts[index]);
                      },
                    ),
                  ),
                ),
              ],
            )));
  }
}
