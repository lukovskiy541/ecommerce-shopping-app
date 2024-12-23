import 'package:flutter/material.dart';

class UserOrdersHistory extends StatelessWidget {
  const UserOrdersHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Orders History'),
      ),
      body: Center(
        child: Text('User Orders History Screen'),
      ),
    );
  }
}
