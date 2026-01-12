import 'package:flutter/material.dart';

import '../widget/app_drawer.dart';
import 'calculatescreen.dart'; // Game 1
import 'second.dart';          // Game 2 (غيري الاسم حسب ملفك)


class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  void _comingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Coming soon...")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("Games Menu"),
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          // ✅ هي أهم شي: منحدد أقصى عرض للـ Grid حتى ما يفلّ
          constraints: const BoxConstraints(maxWidth: 520),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                // ✅ خففي/زيدي حسب شكل الصور
                childAspectRatio: 1.0,
              ),
              children: [
                _GameCard(
                  imagePath: "assets/images/g1.jpg",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const GameScreen()),
                    );
                  },
                ),
                _GameCard(
                  imagePath: "assets/images/g2.jpg",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ShoppingGameScreen(),
                      ),
                    );
                  },
                ),
                _GameCard(
                  imagePath: "assets/images/g3.jpg",
                  onTap: () => _comingSoon(context),
                ),
                _GameCard(
                  imagePath: "assets/images/g4.jpg",
                  onTap: () => _comingSoon(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GameCard extends StatelessWidget {
  final String imagePath;
  final VoidCallback onTap;

  const _GameCard({
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover, // ✅ يعبّي الكارد بدون ما يخرّب
              ),
            ),
            Positioned.fill(
              child: Container(color: Colors.black.withOpacity(0.10)),
            ),
          ],
        ),
      ),
    );
  }
}
