import 'package:ecommerce_app/blocs/categories/categories_bloc.dart';
import 'package:ecommerce_app/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/repositories/categories_repository.dart';

class CatalogScreen extends StatefulWidget {
  static const String routeName = '/catalog';
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  List<Category> _categories = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initTabs();
  }

  void _initTabs() async {
    await _initializeTabController();
  }

  Future<void> _initializeTabController() async {
    final categories =
        await context.read<CategoriesRepository>().getCategories();
    print('success loaded');
    setState(() {
      _categories = categories;
      _tabController = TabController(
        length: _categories.length,
        vsync: this,
      );
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('categories len: ${_categories.length}');
    if (_categories.length == 0) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    } else
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _categories
                  .map((category) => Text(
                        category.name,
                        style: TextStyle(color: Colors.black),
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
