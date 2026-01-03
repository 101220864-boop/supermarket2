import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/homepage.jpg',
              width: 250,
            ),
            Positioned(
              bottom: 15,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () {

                  },
                  child: Image.asset(
                    'assets/images/start_button.jpg',
                    width: 80,
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
