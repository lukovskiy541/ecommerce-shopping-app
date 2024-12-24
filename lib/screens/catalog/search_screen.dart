
import 'package:ecommerce_app/screens/catalog/brands_screen.dart';
import 'package:ecommerce_app/screens/catalog/catalog_screen.dart';
import 'package:flutter/material.dart';

import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            snap: true,
            pinned: false,
            expandedHeight: 100.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Shopping',
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          ),
                        ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        cursorHeight: 20,
                        style: const TextStyle(
                          fontSize: 17,
                          height: 0.9,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Пошук',
                          hintStyle: TextStyle(
                              fontSize: 17,
                              height: 1.1,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade600),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 20,
                          ),
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.only(bottom: 3, top: -3),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
         
                   GestureDetector(
                      onTap: () {
                         pushScreen(
                                  context,
                                  screen: CatalogScreen(),
                                  withNavBar: true,
                                );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Stack(children: [
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
                          
                        ]),
                      ),
                    
                ),
                GestureDetector(
                   onTap: () {
                         pushScreen(
                                  context,
                                  screen: BrandsScreen(),
                                  withNavBar: true,
                                );
                      },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Stack(children: [
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/brands.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Stack(children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/premium.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Stack(children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/home.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  
                  ]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
