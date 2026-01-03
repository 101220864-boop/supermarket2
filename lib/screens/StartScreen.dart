import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center, // centers children by default
          children: [
            Image.asset(
              'assets/images/homepage.jpg',
              width: 250,
            ),
            Positioned(
              bottom: 15, // distance from bottom of the image
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    // action when button is tapped
                  },
                  child: Image.asset(
                    'assets/images/start_button.jpg',
                    width: 80, // small button
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
