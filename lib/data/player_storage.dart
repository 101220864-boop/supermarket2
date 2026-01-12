import 'package:shared_preferences/shared_preferences.dart';

// حفظ اسم اللاعب
Future<void> savePlayerName(String name) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('player_name', name);
}

// قراءة اسم اللاعب
Future<String?> getPlayerName() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('player_name');
}
