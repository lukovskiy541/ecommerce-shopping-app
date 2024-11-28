import 'package:ecommerce_app/blocs/categories/categories_bloc.dart';
import 'package:ecommerce_app/main.dart';
import 'package:ecommerce_app/screens/catalog/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatalogScreen extends StatefulWidget {
  static const String routeName = '/catalog';
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tabController = TabController(
      length: context.watch<CategoriesBloc>().state.categories.length, 
      vsync: this
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
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
                  children: context
                      .watch<CategoriesBloc>()
                      .state
                      .categories
                      .map((category) => Text(category.name, style: TextStyle(color: Colors.black),))
                      .toList(),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
