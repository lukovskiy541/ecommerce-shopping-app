import 'package:ecommerce_app/blocs/signin/signin_cubit.dart';

import 'package:ecommerce_app/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        listener: (context, state) async {
          
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/profile');
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
            body: Padding(
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
                        onPressed:  state.signinStatus == SigninStatus.submiting ? null :  () {
                          Navigator.pushNamed(context, '/signup');
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
          );
        },
      ),
    );
  }
}
