import 'dart:math';
import 'package:flutter/material.dart';
import 'package:supermarket2/screens/calculatescreen.dart';

class ResultScreen extends StatefulWidget {
  final int score;
  final int totalQuestions;

  const ResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_ConfettiPiece> _pieces;
  final _rng = Random();

  bool get _showConfetti => widget.score >= 2; // 🎉 show if score is good (2 or 3)

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _pieces = List.generate(120, (_) => _randomPiece());

    if (_showConfetti) {
      _controller.repeat();
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) _controller.stop();
      });
    }
  }

  _ConfettiPiece _randomPiece() {
    return _ConfettiPiece(
      x: _rng.nextDouble(),
      y: -_rng.nextDouble() * 0.6,
      size: 6 + _rng.nextDouble() * 8,
      speed: 0.35 + _rng.nextDouble() * 0.9,
      sway: (_rng.nextDouble() * 2 - 1) * 0.35,
      rotationSpeed: (_rng.nextDouble() * 2 - 1) * 6,
      color: [
        Colors.redAccent,
        Colors.blueAccent,
        Colors.greenAccent,
        Colors.orangeAccent,
        Colors.purpleAccent,
        Colors.yellowAccent,
        Colors.pinkAccent,
      ][_rng.nextInt(7)],
      angle: _rng.nextDouble() * pi,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _playAgain() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const GameScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final good = widget.score >= 2;

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Image.asset(
              "assets/images/game_bg.png",
              fit: BoxFit.cover,
            ),
          ),


          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.25)),
          ),

          if (_showConfetti)
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (_, __) {
                    return CustomPaint(
                      painter: _ConfettiPainter(
                        pieces: _pieces,
                        t: _controller.value,
                      ),
                    );
                  },
                ),
              ),
            ),


          Center(
            child: Container(
              width: 340,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF6E8C8).withOpacity(0.98),
                borderRadius: BorderRadius.circular(22),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 18,
                    color: Colors.black45,
                    offset: Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2F7BEA),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Text(
                        "RESULT",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),


                  Text(
                    good ? "Great job! 🎉" : "Try again 💪",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  const SizedBox(height: 12),


                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.65),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Your Score",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${widget.score} / ${widget.totalQuestions}",
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                            color: good ? Colors.green.shade700 : Colors.red.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),


                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2F7BEA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: _playAgain,
                      child: const Text(
                        "PLAY AGAIN",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),


                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF2F7BEA), width: 3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        backgroundColor: Colors.white.withOpacity(0.35),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "HOME",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF2F7BEA),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class _ConfettiPiece {
  final double x;
  final double y;
  final double size;
  final double speed;
  final double sway;
  final double rotationSpeed;
  final Color color;
  final double angle;

  _ConfettiPiece({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.sway,
    required this.rotationSpeed,
    required this.color,
    required this.angle,
  });
}

class _ConfettiPainter extends CustomPainter {
  final List<_ConfettiPiece> pieces;
  final double t;

  _ConfettiPainter({required this.pieces, required this.t});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (final p in pieces) {

      final fall = (p.y + p.speed * (t * 3.2)) % 1.4;
      final y = fall * size.height;


      final sway = sin((t * 2 * pi) + p.angle) * p.sway;
      final x = (p.x + sway) * size.width;


      final rot = p.angle + p.rotationSpeed * t;

      paint.color = p.color.withOpacity(0.95);

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(rot);


      final rect = Rect.fromCenter(
        center: Offset.zero,
        width: p.size,
        height: p.size * 1.6,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(2)),
        paint,
      );

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) => true;
}
