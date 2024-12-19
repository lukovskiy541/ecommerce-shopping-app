import 'package:ecommerce_app/screens/registration/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/screens/registration/signup_form.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signup';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
              onPressed: () {
                pushReplacementWithNavBar(
                  context,
                   MaterialPageRoute(builder: (_) => ProfileScreen()),
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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Реєстрація',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30)),
            SizedBox(
              height: 20,
            ),
            Text(
              'Зареєструватися за допомогою',
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
            SignUpForm(),
          ],
        ),
      ),
    );
  }
}
