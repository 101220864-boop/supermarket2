import 'dart:math';
import 'package:flutter/material.dart';
import 'package:supermarket2/screens/resultscreen.dart';
import '../modle/cart-item.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final Random _random = Random();


  int score = 0;
  int answered = 0;
  int questionIndex = 0;
  List<CartItem> cart = [];
  late CartItem itemA;
  late CartItem itemB;

  double correctTotal = 0;
  List<double> choices = [0, 0];
  String feedback = "";

  @override
  void initState() {
    super.initState();
    _newRound();
  }


  String currentOperation() {
    if (questionIndex == 0) return "ADD";
    if (questionIndex == 1) return "MULTIPLY";
    return "SUBTRACT";
  }

  String operationHint() {
    if (questionIndex == 0) {
      return "Add all item totals";
    }
    if (questionIndex == 1) {
      return "Multiply quantities of ${itemA.name} × ${itemB.name}";
    }
    return "Subtract total of ${itemA.name} and ${itemB.name}";
  }


  void _newRound() {
    _generateCart();
    itemA = cart[0];
    itemB = cart[1];
    correctTotal = _round2(_calculateTotal());
    choices = _makeTwoChoices(correctTotal);
    feedback = "";
    setState(() {});
  }

  void _generateCart() {
    final products = [
      {"name": "Milk", "price": 1.50},
      {"name": "Bread", "price": 2.20},
      {"name": "Apple", "price": 0.40},
      {"name": "Cheese", "price": 3.75},
      {"name": "Juice", "price": 2.10},
      {"name": "Eggs", "price": 2.95},
    ];

    cart = List.generate(3, (_) {
      final p = products[_random.nextInt(products.length)];
      return CartItem(
        name: p["name"] as String,
        price: p["price"] as double,
        quantity: _random.nextInt(3) + 1,
      );
    });
  }

  double _calculateTotal() {
    if (questionIndex == 0) {
      double total = 0;
      for (final item in cart) {
        total += item.price * item.quantity;
      }
      return total;
    }

    if (questionIndex == 1) {
      return (itemA.quantity * itemB.quantity).toDouble();
    }


    final a = itemA.price * itemA.quantity;
    final b = itemB.price * itemB.quantity;
    return a >= b ? a - b : b - a;
  }

  double _round2(double v) => (v * 100).round() / 100;

  List<double> _makeTwoChoices(double correct) {
    double wrong;
    do {
      final delta = (_random.nextInt(7) + 1) * 0.5;
      wrong = correct + (_random.nextBool() ? delta : -delta);
      wrong = _round2(wrong);
    } while (wrong <= 0 || wrong == correct);

    final list = [correct, wrong]..shuffle(_random);
    return list;
  }

  void _openChoicesBox() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 300,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFF6E8C8),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 18,
                    color: Colors.black45,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Choose the Answer",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    operationHint(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 18),
                  _gameChoiceButton(choices[0]),
                  const SizedBox(height: 12),
                  _gameChoiceButton(choices[1]),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _gameChoiceButton(double value) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2F7BEA),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
          _checkAnswer(value);
        },
        child: Text(
          "\$${value.toStringAsFixed(2)}",
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _checkAnswer(double selected) {
    final ok = selected == correctTotal;

    setState(() {
      answered++;
      if (ok) score++;
      feedback = ok ? "✅ Correct!" : "❌ Wrong!";
    });

    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;

      if (questionIndex < 2) {
        questionIndex++;
        _newRound();
      } else {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ResultScreen(
              score: score,
              totalQuestions: 3,
            ),
          ),
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Positioned.fill(
            child: Image.asset(
              "assets/images/game_bg.png",
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            top: 25,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  "Question ${questionIndex + 1} / 3  —  ${currentOperation()}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: 70,
            left: 20,
            right: 20,
            child: Center(
              child: Text(
                operationHint(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  shadows: [Shadow(blurRadius: 6, color: Colors.black54)],
                ),
              ),
            ),
          ),

          Positioned(
            left: 20,
            top: 110,
            child: Container(
              width: 320,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF6E8C8),
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 12,
                    color: Colors.black26,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2F7BEA),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Text(
                      "Your Cart",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  for (final item in cart)
                    _cartRow(
                      item.name,
                      item.quantity,
                      item.price.toStringAsFixed(2),
                    ),
                ],
              ),
            ),
          ),

          // FEEDBACK
          if (feedback.isNotEmpty)
            Positioned(
              bottom: 130,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.55),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    feedback,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

          Positioned(
            left: 20,
            bottom: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ResultScreen(
                      score: score,
                      totalQuestions: answered == 0 ? 3 : answered,
                    ),
                  ),
                );
              },
              child: Image.asset(
                "assets/ui/btn_left.png",
                width: 220,
              ),
            ),
          ),

          Positioned(
            right: 20,
            bottom: 20,
            child: GestureDetector(
              onTap: _openChoicesBox,
              child: Image.asset(
                "assets/ui/btn_right.png",
                width: 220,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


Widget _cartRow(String name, int qty, String price) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.6),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        const Icon(Icons.shopping_bag, size: 26),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            "$name x$qty",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          "\$$price",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
