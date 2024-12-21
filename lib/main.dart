import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/blocs/auth/auth_bloc.dart';
import 'package:ecommerce_app/blocs/bloc/deliverysearch_bloc.dart';
import 'package:ecommerce_app/blocs/cart/cart_bloc.dart';
import 'package:ecommerce_app/blocs/genders/genders_bloc.dart';
import 'package:ecommerce_app/blocs/navigation/navigation_cubit.dart';
import 'package:ecommerce_app/blocs/products/products_bloc.dart';
import 'package:ecommerce_app/blocs/profile/profile_cubit.dart';
import 'package:ecommerce_app/blocs/signin/signin_cubit.dart';
import 'package:ecommerce_app/blocs/signin/signup_cubit.dart';
import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/repositories/auth_repository.dart';
import 'package:ecommerce_app/repositories/brands_repository.dart';
import 'package:ecommerce_app/repositories/cart_repository.dart';
import 'package:ecommerce_app/repositories/genders_repository.dart';
import 'package:ecommerce_app/repositories/products_repository.dart';
import 'package:ecommerce_app/repositories/profile_repository.dart';

import 'package:ecommerce_app/screens/cart/cart_screen.dart';
import 'package:ecommerce_app/screens/main%20pages/liked_screen.dart';

import 'package:ecommerce_app/screens/catalog/search_screen.dart';
import 'package:ecommerce_app/screens/main%20pages/shops_screen.dart';
import 'package:ecommerce_app/utils/my_flutter_app_icons.dart';
import 'package:ecommerce_app/screens/for_you/for_you_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;
import 'package:faker/faker.dart';
import 'dart:convert';
import 'dart:math';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

Future<void> createTestProducts({required String pexelsApiKey}) async {
  final CollectionReference productsRef =
      FirebaseFirestore.instance.collection('products');

  // Faker для генерації текстових даних
  final Faker faker = Faker();
  final Random random = Random();

  // Запит до Pexels API для отримання зображень
  Future<List<String>> fetchImages(String query, int count) async {
    final response = await http.get(
      Uri.parse(
          'https://api.pexels.com/v1/search?query=$query&per_page=$count'),
      headers: {'Authorization': pexelsApiKey},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<String>.from(
          data['photos'].map((photo) => photo['src']['medium']));
    } else {
      throw Exception('Failed to fetch images');
    }
  }

  try {
    // Отримуємо зображення для взуття
    final List<String> images = await fetchImages('sandals', 10);

    // Створюємо продукти
    final List<Map<String, dynamic>> dummyProducts = List.generate(5, (index) {
      final categoryName = faker.food.cuisine();
      final subCategoryName = faker.food.dish();
      return {
        'id': faker.guid.guid(),
        'name': faker.lorem.words(3).join(' '),
        'description': faker.lorem.sentence(),
        'price': (random.nextDouble() * 2000).toStringAsFixed(2),
        'images': [images[random.nextInt(images.length)]],
        'category': {
          'id': faker.guid.guid(),
          'name': categoryName,
        },
        'subCategory': {
          'id': faker.guid.guid(),
          'name': subCategoryName,
        },
        'availableSizes': ['36', '37', '38', '39', '40'],
        'availableColors': ['Чорний', 'Білий', 'Сірий'],
        'bonusPoints': random.nextInt(20),
        'bonusPointsForSubscribers': random.nextInt(40),
        'brand': faker.company.name(),
        'seller': faker.person.name(),
        'stock': random.nextInt(50),
        'isFavorite': random.nextBool(),
        'gender': {
          'id': faker.guid.guid(),
          'name': random.nextBool() ? 'Жінки' : 'Чоловіки',
        },
        'productType': {
          'id': faker.guid.guid(),
          'name': 'Взуття',
        },
      };
    });

    // Додаємо продукти до Firestore
    for (final product in dummyProducts) {
      await productsRef.doc(product['id']).set(product);
    }

    print('Продукти успішно створені!');
  } catch (e) {
    print('Помилка під час створення продуктів: $e');
  }
}

Future<void> createProductsCollection() async {
  final CollectionReference productsRef =
      FirebaseFirestore.instance.collection('products');

  final Category sandalsCategory = Category(
    id: 'sandals-category-id',
    name: 'Босоніжки',
    imageUrl: 'category-image-url',
    subCategories: [
      SubCategory(
        id: 'casual-sandals-id',
        name: 'Кежуал босоніжки',
        imageUrl: 'subcategory-image-url',
      ),
      SubCategory(
        id: 'elegant-sandals-id',
        name: 'Елегантні босоніжки',
        imageUrl: 'subcategory-image-url',
      ),
    ],
  );

  final Gender femaleGender = Gender(
    id: 'female-id',
    name: 'Жінки',
    productTypes: [
      ProductType(
        id: 'footwear-id',
        name: 'Взуття',
        imageUrl: 'gender-image-url',
        categories: [sandalsCategory],
      ),
    ],
  );

  final List<Product> products = [
    Product(
      id: '1',
      name: 'Чорні елегантні босоніжки',
      description: 'Чудові босоніжки для будь-якої події.',
      price: 1500.0,
      images: [
        'https://example.com/casual-sandals.jpg',
        'https://example.com/casual-sandals.jpg',
        'https://example.com/casual-sandals.jpg'
      ],
      category: sandalsCategory,
      subCategory: sandalsCategory.subCategories.first,
      availableSizes: ['36', '37', '38', '39', '40'],
      availableColors: ['Чорний'],
      bonusPoints: 10,
      bonusPointsForSubscribers: 20,
      brand: 'ElegantWear',
      seller: 'BestShoesSeller',
      gender: femaleGender,
      productType: femaleGender.productTypes.first,
      stock: 25,
    ),
    Product(
      id: '2',
      name: 'Кежуал босоніжки',
      description: 'Зручні босоніжки на щодень.',
      price: 1200.0,
      images: [
        'https://example.com/casual-sandals.jpg',
        'https://example.com/casual-sandals.jpg',
        'https://example.com/casual-sandals.jpg'
      ],
      category: sandalsCategory,
      subCategory: sandalsCategory.subCategories.last,
      availableSizes: ['37', '38', '39', '40', '41'],
      availableColors: ['Бежевий', 'Коричневий'],
      bonusPoints: 15,
      bonusPointsForSubscribers: 25,
      brand: 'ComfortLine',
      seller: 'EverydayStyle',
      gender: femaleGender,
      productType: femaleGender.productTypes.first,
      stock: 30,
    ),
  ];

  try {
    for (final product in products) {
      await productsRef.doc(product.id).set(product.toFirestore());
    }
    print('Колекція продуктів успішно створена.');
  } catch (e) {
    print('Помилка при створенні продуктів: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
              firebaseFirestore: FirebaseFirestore.instance,
              firebaseAuth: FirebaseAuth.instance),
        ),
        RepositoryProvider<CartRepository>(
            create: (context) => CartRepository(
                  firebaseFirestore: FirebaseFirestore.instance,
                )),
        RepositoryProvider<ProfileRepository>(
          create: (context) => ProfileRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
        RepositoryProvider<ProductsRepository>(
          create: (context) => ProductsRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
        RepositoryProvider<GendersRepository>(
          create: (context) => GendersRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
        RepositoryProvider<BrandsRepository>(
          create: (context) => BrandsRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<DeliverysearchBloc>(
            create: (context) => DeliverysearchBloc(
            ),
          ),
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<SignupCubit>(
            create: (context) => SignupCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<SigninCubit>(
            create: (context) => SigninCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubit(
              profileRepository: context.read<ProfileRepository>(),
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<ProductsBloc>(
            create: (context) => ProductsBloc(
              productsRepository: context.read<ProductsRepository>(),
            ),
          ),
          BlocProvider<GendersBloc>(
            create: (context) => GendersBloc(
              gendersRepository: context.read<GendersRepository>(),
            ),
          ),
          BlocProvider<CartBloc>(
            create: (context) => CartBloc(
              cartRepository: context.read<CartRepository>(),
              profileCubit: context.read<ProfileCubit>(),
            ),
          ),
          BlocProvider<NavigationCubit>(
            create: (context) => NavigationCubit(),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal.shade400),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: BlocBuilder<NavigationCubit, NavigationState>(
              builder: (context, currentIndex) {
            return PersistentTabView(
              controller: context.read<NavigationCubit>().controller,
              
              tabs: [
                PersistentTabConfig(
                  screen: ForYouScreen(),
                  item: ItemConfig(
                      activeForegroundColor: Colors.black,
                      inactiveForegroundColor: Colors.grey,
                      icon: Icon(
                        MyFlutterApp.logo,
                        size: 24,
                      )),
                ),
                PersistentTabConfig(
                  screen: SearchScreen(),
                  item: ItemConfig(
                    activeForegroundColor: Colors.black,
                    inactiveForegroundColor: Colors.grey,
                    icon: Icon(Icons.search),
                  ),
                ),
                PersistentTabConfig(
                  screen: CartScreen(),
                  item: ItemConfig(
                    activeForegroundColor: Colors.black,
                    inactiveForegroundColor: Colors.grey,
                    icon: Icon(Icons.shopping_basket_outlined),
                  ),
                ),
                PersistentTabConfig(
                  screen: LikedScreen(),
                  item: ItemConfig(
                    activeForegroundColor: Colors.black,
                    inactiveForegroundColor: Colors.grey,
                    icon: Icon(Icons.favorite_border),
                  ),
                ),
                PersistentTabConfig(
                  screen: ShopsScreen(),
                  item: ItemConfig(
                    activeForegroundColor: Colors.black,
                    inactiveForegroundColor: Colors.grey,
                    icon: Icon(Icons.check_box_outline_blank_sharp),
                  ),
                )
              ],
              
              navBarBuilder: (navBarConfig) => Style1BottomNavBar(
                navBarConfig: navBarConfig,
              ),
            );
          }),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const String routeName = '/';
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double iconSize = 35;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // bottomNavigationBar: Container(
        //   height: 50,
        //   color: Colors.white,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: [
        //       IconButton(
        //         padding: EdgeInsets.zero,
        //         icon: Icon(MyFlutterApp.logo,
        //             size: 24,
        //             color: _selectedIndex == 0 ? Colors.black : Colors.grey),
        //         onPressed: () {
        //           _onItemTapped(0);
        //         },
        //         enableFeedback: false,
        //         splashRadius: 100,
        //       ),
        //       IconButton(
        //         padding: EdgeInsets.zero,
        //         icon: Icon(Icons.search,
        //             size: 24,
        //             color: _selectedIndex == 1 ? Colors.black : Colors.grey),
        //         onPressed: () {
        //           _onItemTapped(1);
        //         },
        //         enableFeedback: false,
        //         splashRadius: 70,
        //       ),
        //       IconButton(
        //         padding: EdgeInsets.zero,
        //         icon: Icon(Icons.shopping_bag_outlined,
        //             size: 24,
        //             color: _selectedIndex == 2 ? Colors.black : Colors.grey),
        //         onPressed: () {
        //           _onItemTapped(2);
        //         },
        //         enableFeedback: false,
        //         splashRadius: 70,
        //       ),
        //       IconButton(
        //         padding: EdgeInsets.zero,
        //         icon: Icon(Icons.favorite_outline,
        //             size: 24,
        //             color: _selectedIndex == 3 ? Colors.black : Colors.grey),
        //         onPressed: () {
        //           _onItemTapped(3);
        //         },
        //         enableFeedback: false,
        //         splashRadius: 70,
        //       ),
        //       IconButton(
        //         padding: EdgeInsets.zero,
        //         icon: Icon(Icons.shop_2_outlined,
        //             size: 24,
        //             color: _selectedIndex == 4 ? Colors.black : Colors.grey),
        //         onPressed: () {
        //           _onItemTapped(4);
        //         },
        //         splashRadius: 70,
        //       ),
        //     ],
        //   ),
        // ),
        // body: Center(
        //   child: _pages.elementAt(_selectedIndex),
        // ),
        );
  }
}
