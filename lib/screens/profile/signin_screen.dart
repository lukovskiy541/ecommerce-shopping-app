import 'package:ecommerce_app/blocs/signin/signin_cubit.dart';
import 'package:ecommerce_app/screens/profile/profile_screen.dart';
import 'package:ecommerce_app/screens/profile/signup_screen.dart';

import 'package:ecommerce_app/screens/profile/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = '/signin';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocConsumer<SigninCubit, SigninState>(
        listener: (context, state) async {},
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: [
                TextButton(
                    onPressed: () {
                      pushScreenWithNavBar(
                        context,
                        ProfileScreen(),
                      );
                    },
                    child: Text(
                      'Закрити',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ))
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Вхід',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30)),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Увійти за допомогою',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        // buttons for oauth
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        'або',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    Container(
                      height: 30,
                      // phone or email
                    ),
                    LoginForm(),
                    Center(
                      child: TextButton(
                          onPressed: state.signinStatus == SigninStatus.submiting
                              ? null
                              : () {
                                  pushScreen(
                                    context,
                                    screen: SignUpScreen(),
                                    withNavBar: true,
                                  );
                                },
                          child: Text(
                            'Зареєструватися',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          )),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
