import 'package:flutter/material.dart';

class GameHeader extends StatelessWidget {
  final int questionIndex;
  final String operationText;
  final String hintText;

  const GameHeader({
    super.key,
    required this.questionIndex,
    required this.operationText,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            "Question ${questionIndex + 1} / 3  —  $operationText",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          hintText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
