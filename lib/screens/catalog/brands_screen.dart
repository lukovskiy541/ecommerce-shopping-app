import 'package:ecommerce_app/models/brand_model.dart';

import 'package:ecommerce_app/repositories/brands_repository.dart';
import 'package:ecommerce_app/screens/catalog/brand_page_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class BrandsScreen extends StatefulWidget {
  static const String routeName = '/brands';
  const BrandsScreen({super.key});

  @override
  State<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> with TickerProviderStateMixin {
  List<Brand> _allBrands = [];
  List<Brand> _filteredBrands = [];
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _initBrands();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _initBrands() async {
    final brands = await context.read<BrandsRepository>().getBrands();
    setState(() {
      _allBrands = brands;
      _filteredBrands = brands;
    });
  }

  Map<String, List<Brand>> _groupBrandsByLetter() {
    final grouped = <String, List<Brand>>{};
    
    final sortedBrands = [..._filteredBrands]
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    for (var brand in sortedBrands) {
      final letter = brand.name[0].toUpperCase();
      grouped.putIfAbsent(letter, () => []);
      grouped[letter]!.add(brand);
    }

    return Map.fromEntries(
      grouped.entries.toList()..sort((a, b) => a.key.compareTo(b.key))
    );
  }

  void _filterBrands(String searchTerm) {
    setState(() {
      _filteredBrands = _allBrands
          .where((brand) => 
              brand.name.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final groupedBrands = _groupBrandsByLetter();
    
    if (_allBrands.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

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
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/brands.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 40,
              margin: const EdgeInsets.only(top: 16, left: 8, right: 8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextField(
                controller: _searchController,
                textAlignVertical: TextAlignVertical.center,
                cursorHeight: 20,
                style: const TextStyle(
                  fontSize: 17,
                  height: 0.9,
                  fontWeight: FontWeight.bold,
                ),
                onChanged: _filterBrands,
                decoration: InputDecoration(
                  hintText: 'Пошук',
                  hintStyle: TextStyle(
                    fontSize: 17,
                    height: 1.1,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 20,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(bottom: 3, top: -3),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 5),
                itemCount: groupedBrands.length * 2,
                itemBuilder: (context, index) {
                  final letterIndex = index ~/ 2;
                  final letter = groupedBrands.keys.elementAt(letterIndex);
                  
                  if (index.isOdd) {
                    return Column(
                      children: groupedBrands[letter]!
                          .map((brand) => ListTile(
                                style: ListTileStyle.drawer,
                                title: Text(brand.name),
                                onTap: () => pushScreenWithNavBar(context, BrandPageScreen(brand: brand)),
                              ))
                          .toList(),
                    );
                  } else {
                    return Container(
                      color: Colors.grey[200],
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                      child: Text(
                        letter,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
