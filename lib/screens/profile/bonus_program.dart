import 'package:flutter/material.dart';

class BonusProgramScreen extends StatelessWidget {
  const BonusProgramScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bonus Program'),
      ),
      body: Center(
        child: Text('Bonus Program Screen'),
      ),
    );
  }
}