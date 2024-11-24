import 'package:ecommerce_app/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Мій аккаунт',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: Center(
            child: Column(
              children: [
                Text('Profile photo'),
                if (state.authStatus == AuthStatus.unauthenticated)
                    GestureDetector(
                      child: Container(
                        color: Colors.black,
                        child: Text(
                          'Увійти',
                          style: TextStyle(color: Colors.white),
                        ),
                        height: 50,
                        width: 100,
                      ),
                      onTap: () => Navigator.pushNamed(context, '/signin'),
                    ),
                  
              ],
            ),
          ),
        );
      },
    );
  }
}
