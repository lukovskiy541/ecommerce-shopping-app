import 'package:ecommerce_app/my_flutter_app_icons.dart';
import 'package:ecommerce_app/screens/for_you_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal.shade400),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double iconSize = 35;
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
  ForYouScreen(),
  Icon(
    Icons.camera,
    size: 150,
  ),
  Icon(
    Icons.chat,
    size: 150,
  ),
   Icon(
    Icons.call,
    size: 150,
  ),
   Icon(
    Icons.call,
    size: 150,
  ),
];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              icon:
                   Icon(MyFlutterApp.logo, size: 24, color: _selectedIndex == 0 ? Colors.black : Colors.grey),
              onPressed: () {
                _onItemTapped(0);
              },
              enableFeedback: false,
              splashRadius: 100,
            ),
            IconButton(
              padding: EdgeInsets.zero,
              icon:  Icon(Icons.search, size: 24, color: _selectedIndex == 1 ? Colors.black : Colors.grey),
              onPressed: () {
                _onItemTapped(1);
              },
              enableFeedback: false,
              splashRadius: 70,
            ),
            IconButton(
              padding: EdgeInsets.zero,
              icon:  Icon(Icons.shopping_bag_outlined,
                  size: 24, color: _selectedIndex == 2 ? Colors.black : Colors.grey),
              onPressed: () {
                _onItemTapped(2);
              },
              enableFeedback: false,
              splashRadius: 70,
            ),
            IconButton(
              padding: EdgeInsets.zero,
              icon:  Icon(Icons.favorite_outline,
                  size: 24, color: _selectedIndex == 3 ? Colors.black : Colors.grey),
              onPressed: () {
                _onItemTapped(3);
              },
              enableFeedback: false,
              splashRadius: 70,
            ),
            IconButton(
              padding: EdgeInsets.zero,
              icon:  Icon(Icons.shop_2_outlined,
                  size: 24, color: _selectedIndex == 4 ? Colors.black : Colors.grey),
              onPressed: () {
                _onItemTapped(4);
              },
              splashRadius: 70,
            ),
          ],
        ),
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
    );
  }
}
