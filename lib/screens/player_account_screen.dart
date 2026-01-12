import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PlayerAccountScreen extends StatefulWidget {
  const PlayerAccountScreen({super.key});

  @override
  State<PlayerAccountScreen> createState() => _PlayerAccountScreenState();
}

class _PlayerAccountScreenState extends State<PlayerAccountScreen> {
  final TextEditingController _nameController = TextEditingController();


  // حفظ الاسم
  Future<void> savePlayerName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('player_name', _nameController.text);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Name saved")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Player Account")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Enter your name",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Player Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: savePlayerName,
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
