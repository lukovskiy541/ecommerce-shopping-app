import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/blocs/auth/auth_bloc.dart';
import 'package:ecommerce_app/blocs/signin/signin_cubit.dart';
import 'package:ecommerce_app/repositories/auth_repository.dart';
import 'package:ecommerce_app/screens/registration/signin_screen.dart';
import 'package:ecommerce_app/screens/registration/signup_screen.dart';
import 'package:ecommerce_app/screens/registration/profile_screen.dart';
import 'package:ecommerce_app/utils/my_flutter_app_icons.dart';
import 'package:ecommerce_app/screens/for_you_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
           BlocProvider<SigninCubit>(
            create: (context) => SigninCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          )
        ],
        child: MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal.shade400),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          routes: {
            SignInScreen.routeName: (context) => SignInScreen(),
            SignUpScreen.routeName: (context) => SignUpScreen(),
            ProfileScreen.routeName: (context) => ProfileScreen(),
            '/': (context) => MyHomePage(),
          },
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
                  icon: Icon(MyFlutterApp.logo,
                      size: 24,
                      color: _selectedIndex == 0 ? Colors.black : Colors.grey),
                  onPressed: () {
                    _onItemTapped(0);
                  },
                  enableFeedback: false,
                  splashRadius: 100,
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.search,
                      size: 24,
                      color: _selectedIndex == 1 ? Colors.black : Colors.grey),
                  onPressed: () {
                    _onItemTapped(1);
                  },
                  enableFeedback: false,
                  splashRadius: 70,
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.shopping_bag_outlined,
                      size: 24,
                      color: _selectedIndex == 2 ? Colors.black : Colors.grey),
                  onPressed: () {
                    _onItemTapped(2);
                  },
                  enableFeedback: false,
                  splashRadius: 70,
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.favorite_outline,
                      size: 24,
                      color: _selectedIndex == 3 ? Colors.black : Colors.grey),
                  onPressed: () {
                    _onItemTapped(3);
                  },
                  enableFeedback: false,
                  splashRadius: 70,
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.shop_2_outlined,
                      size: 24,
                      color: _selectedIndex == 4 ? Colors.black : Colors.grey),
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

