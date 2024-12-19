import 'package:ecommerce_app/screens/registration/profile_screen.dart';
import 'package:ecommerce_app/screens/for_you/popular_products.dart';
import 'package:ecommerce_app/screens/for_you/products_of_day.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class ForYouScreen extends StatelessWidget {
  const ForYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
                        'Для тебе',
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: GestureDetector(
                            onTap: () {
                              pushScreen(
                                context,
                                screen: ProfileScreen(),
                                withNavBar: true,
                              );
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              child: const Icon(Icons.person),
                            ),
                          ))
                    ],
                  ),
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
          delegate: SliverChildListDelegate([
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/subscription_banner.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipRRect(
                  child: Image.asset(
                    'assets/sale.jpg',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipRRect(
                  child: Image.asset(
                    'assets/sale2.jpg',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            PopularProducts(),
            ProductsOfDay(),
            ProductsOfDay(),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipRRect(
                  child: Image.asset(
                    'assets/brand1.jpg',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipRRect(
                  child: Image.asset(
                    'assets/brand2.jpg',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipRRect(
                  child: Image.asset(
                    'assets/brand3.jpg',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                          color: Colors.grey,
                          height: 150,
                          width: 200,
                          child: Image.asset(
                            'assets/brand.jpg',
                            height: 150,
                            width: 200,
                            fit: BoxFit.cover,
                          )));
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 400,
              child: PageView.builder(
                controller: PageController(
                  viewportFraction: 0.9,
                  initialPage: 0,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.grey,
                          height: 200,
                          width: 390,
                          child: Image.asset(
                            'assets/adv.jpg',
                            height: 300,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          'Щоб закутатись',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          'тепло і вигідно',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
