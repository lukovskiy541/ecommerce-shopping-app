import 'package:ecommerce_app/blocs/products/products_bloc.dart';
import 'package:ecommerce_app/blocs/profile/profile_cubit.dart';
import 'package:ecommerce_app/models/brand_model.dart';
import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/repositories/genders_repository.dart';
import 'package:ecommerce_app/screens/catalog/catalog_categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class BrandPageScreen extends StatefulWidget {
  final Brand brand;

  BrandPageScreen({super.key, required this.brand});

  @override
  State<BrandPageScreen> createState() => _BrandPageScreenState();
}

class _BrandPageScreenState extends State<BrandPageScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController; // Make nullable instead of late
  List<Gender> _genders = [];
  bool _isLoading = true; // Add loading state

  @override
  void initState() {
    super.initState();
    _initTabs();
  }

  void _initTabs() async {
    await _initializeTabController();
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _initializeTabController() async {
    print('Starting initialization for brand: ${widget.brand.name}');

    final products = context
        .read<ProductsBloc>()
        .state
        .products
        .where((product) => product.brand == widget.brand.name)
        .toList();
    
    print('Found ${products.length} products for this brand');
    print('Product types: ${products.map((p) => p.productType).toSet().toList()}');

    final allGenders = await context.read<GendersRepository>().getGenders();
    print('Loaded ${allGenders.length} genders from repository');
    print('Available genders: ${allGenders.map((g) => g.name).toList()}');

    final genders = allGenders
        .map((gender) {
          final filteredProductTypes = gender.productTypes.where((productType) {
            final hasMatchingProducts = products
                .any((product) => product.productType == productType.name);
            print('Gender ${gender.name} - ProductType ${productType.name}: hasMatchingProducts=$hasMatchingProducts');
            return hasMatchingProducts;
          }).toList();

          return Gender(
            id: gender.id,
            name: gender.name,
            productTypes: filteredProductTypes,
          );
        })
        .where((gender) => gender.productTypes.isNotEmpty)
        .toList();

    print('Final filtered genders count: ${genders.length}');
    print('Filtered genders: ${genders.map((g) => '${g.name}(${g.productTypes.length} products)').toList()}');

    if (mounted) {
      setState(() {
        _genders = genders;
        if (genders.isNotEmpty) {
          _tabController = TabController(
            length: _genders.length,
            vsync: this,
          );
          print('TabController initialized with ${_genders.length} tabs');
        } else {
          print('WARNING: No genders with matching products found!');
        }
      });
    }
}

  @override
  void dispose() {
    _tabController?.dispose(); // Safe disposal with null check
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = context.read<ProfileCubit>().state.user;

    // Show loading indicator while initializing
    if (_isLoading || _tabController == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
        ),
        extendBodyBehindAppBar: true,
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(16),
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(widget.brand.imageUrl),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      user.favoriteCategories.contains(widget.brand.name)
                          ? user.favoriteCategories.remove(widget.brand.name)
                          : user.favoriteCategories.add(widget.brand.name);

                      context.read<ProfileCubit>().updateProfile(user: user);
                    },
                    icon: Icon(
                        user.favoriteCategories.contains(widget.brand.name)
                            ? Icons.favorite
                            : Icons.favorite_border)),
                SizedBox(width: 16),
                IconButton(
                    onPressed: () {
                      user.favoriteCategories.contains(widget.brand.name)
                          ? user.favoriteCategories.remove(widget.brand.name)
                          : user.favoriteCategories.add(widget.brand.name);

                      context.read<ProfileCubit>().updateProfile(user: user);
                    },
                    icon: Icon(Icons.heart_broken_outlined)),
              ],
            ),
            SizedBox(height: 16),
            TabBar.secondary(
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              indicatorPadding: EdgeInsets.zero,
              controller:
                  _tabController!, // Safe to use ! here as we check above
              padding: EdgeInsets.zero,
              tabs: _genders
                  .map((category) => Tab(
                        text: category.name,
                      ))
                  .toList(),
            ),
            Expanded(
              child: TabBarView(
                controller:
                    _tabController!, // Safe to use ! here as we check above
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
