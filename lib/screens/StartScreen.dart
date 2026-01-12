import 'package:flutter/material.dart';
import 'package:supermarket2/screens/menu.dart';

import 'package:supermarket2/data/player_storage.dart';

import '../widget/app_drawer.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  String? playerName;

  @override
  void initState() {
    super.initState();
    _loadPlayerName();
  }

  Future<void> _loadPlayerName() async {
    final name = await getPlayerName();
    setState(() {
      playerName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),

      body: Builder(
        builder: (scaffoldContext) {
          return Stack(
            children: [
              // ✅ Full screen background
              Positioned.fill(
                child: Image.asset(
                  'assets/images/homepage.jpg',
                  fit: BoxFit.cover,
                ),
              ),

              // ✅ Menu (Drawer) button in the top-left
              Positioned(
                top: 40,
                left: 15,
                child: GestureDetector(
                  onTap: () => Scaffold.of(scaffoldContext).openDrawer(),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ),

              // ✅ Welcome text (optional)
              Positioned(
                top: 95,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.35),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      playerName == null ? "Welcome!" : "Welcome, $playerName",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),

              // ✅ Start button (image) -> go to MenuScreen
              Positioned(
                bottom: 15,
                left: 0,
                right: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MenuScreen(),
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/images/start_button.jpg',
                      width: 120,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
