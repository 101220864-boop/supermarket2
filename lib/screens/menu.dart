import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/images/g1.jpg'),
              width: 150,
              height: 150,
            ),
            const SizedBox(width: 16),
            const Text('Cashier', style: TextStyle(fontSize: 20)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/images/g1.jpg'),
              width: 150,
              height: 150,
            ),
            const SizedBox(width: 16),
            const Text('Cashier', style: TextStyle(fontSize: 20)),
          ],
        ),
      ],
    );
  }
}
