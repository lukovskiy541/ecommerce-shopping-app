import 'package:flutter/material.dart';

class FullscreenBackgroundImage extends StatelessWidget {
  const FullscreenBackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/empty_bucket.jpg',
                fit: BoxFit.cover,
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
