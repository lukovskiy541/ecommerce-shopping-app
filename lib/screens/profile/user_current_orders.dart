import 'package:flutter/material.dart';

class UserOrders extends StatelessWidget {
  const UserOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Orders'),
      ),
      body: Center(
        child: Text('User Orders Screen'),
      ),
    );
  }
}
