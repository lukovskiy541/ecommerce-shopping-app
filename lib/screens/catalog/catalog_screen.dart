import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/screens/catalog/catalog_categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/repositories/genders_repository.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CatalogScreen extends StatefulWidget {
  static const String routeName = '/catalog';
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  List<Gender> _genders = [];

  @override
  void initState() {
    super.initState();
    _initTabs();
  }

  void _initTabs() async {
    await _initializeTabController();
  }

  Future<void> _initializeTabController() async {
    final genders = await context.read<GendersRepository>().getGenders();
    print('success loaded');
    setState(() {
      _genders = genders;
      _tabController = TabController(
        length: _genders.length,
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
    print('categories len: ${_genders.length}');
    if (_genders.length == 0) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    } else
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
          ),
          extendBodyBehindAppBar: true,
          body: Column(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/catalog.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              TabBar.secondary(
                tabAlignment: TabAlignment.start,
                isScrollable: true,
                indicatorPadding: EdgeInsets.zero,
                controller: _tabController,
                padding: EdgeInsets.zero,
                tabs: _genders
                    .map((category) => Tab(
                          text: category.name,
                        ))
                    .toList(),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: _genders
                      .map((gender) => Tab(
                            child: ListView.separated(
                              itemCount: gender.productTypes.length,
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 20);
                              },
                              itemBuilder: (context, int index) =>
                                  GestureDetector(
                                onTap: () {
                                  pushScreen(
                                    context,
                                    screen: CatalogCategoryScreen(
                                        productType: gender.productTypes[index],
                                        gender: gender),
                                    withNavBar: true,
                                  );
                                },
                                child: Container(
                                  height: 150,
                                  color: Colors.grey.shade100,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  width: double.maxFinite,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ConstrainedBox(
                                        constraints:
                                            BoxConstraints(maxWidth: 230),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 30.0),
                                          child: Text(
                                            gender.productTypes[index].name,
                                            softWrap: true,
                                            overflow: TextOverflow.visible,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30),
                                          ),
                                        ),
                                      ),
                                      Image.asset(
                                        'assets/shoe.jpg',
                                        width: 150,
                                        height: 150,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              )
            ],
          ),
        ),
      );
  }
}
