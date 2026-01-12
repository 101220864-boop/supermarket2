import 'package:flutter/material.dart';

class Item {
  final String id;
  final String name;
  final String emoji;
  final Color color;
  final bool onList;

  const Item({
    required this.id,
    required this.name,
    required this.emoji,
    required this.color,
    required this.onList,
  });
}

class ShoppingGameScreen extends StatefulWidget {
  const ShoppingGameScreen({super.key});

  @override
  State<ShoppingGameScreen> createState() => _ShoppingGameScreenState();
}

class _ShoppingGameScreenState extends State<ShoppingGameScreen> {
  final List<Item> cart = [];
  String? wrongItemId;
  bool gameComplete = false;

  final List<Item> items = [
    const Item(id: 'berry', name: 'Berry Snacks', emoji: '🫐', color: Color(0xFFF8BBD0), onList: true),
    const Item(id: 'noodle', name: 'Noodle Cup', emoji: '🍜', color: Color(0xFFFFE0B2), onList: true),
    const Item(id: 'onigiri', name: 'Onigiri', emoji: '🍙', color: Color(0xFF66BB6A), onList: false),
    const Item(id: 'bread', name: 'Bread', emoji: '🍞', color: Color(0xFFFFF9C4), onList: false),
  ];

  int _countInCart(String id) => cart.where((i) => i.id == id).length;

  void _checkGameComplete() {
    if (_countInCart('berry') >= 1 && _countInCart('noodle') >= 2) {
      setState(() => gameComplete = true);
    }
  }

  void _resetGame() {
    setState(() {
      cart.clear();
      gameComplete = false;
      wrongItemId = null;
    });
  }

  Widget _itemBox(Item item, {bool shadow = false}) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: item.color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: shadow
            ? [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 6))]
            : null,
      ),
      child: Center(child: Text(item.emoji, style: const TextStyle(fontSize: 32))),
    );
  }

  Widget _buildShelf(List<Item> shelfItems) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: shelfItems.map((item) {
        return Draggable<Item>(
          data: item,
          feedback: _itemBox(item, shadow: true),
          childWhenDragging: Opacity(opacity: 0.35, child: _itemBox(item)),
          child: _itemBox(item),
        );
      }).toList(),
    );
  }

  Widget _checkItem({required String label, required String id, required int need}) {
    final have = _countInCart(id);
    final done = have >= need;
    return Row(
      children: [
        Icon(done ? Icons.check_circle : Icons.radio_button_unchecked, color: done ? Colors.green : Colors.black54),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            "$label  ($have/$need)",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: done ? Colors.green.shade800 : Colors.black87),
          ),
        ),
      ],
    );
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Great! 🎉"),
        content: const Text("You completed the checklist!"),
        actions: [
          TextButton(onPressed: () { Navigator.pop(context); _resetGame(); }, child: const Text("Play again")),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("Close")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final snackShelf = [
      items.firstWhere((i) => i.id == 'berry'),
      items.firstWhere((i) => i.id == 'noodle'),
      items.firstWhere((i) => i.id == 'noodle'),
    ];
    final middleShelf = [
      items.firstWhere((i) => i.id == 'onigiri'),
      items.firstWhere((i) => i.id == 'onigiri'),
      items.firstWhere((i) => i.id == 'onigiri'),
    ];
    final bottomShelf = [
      items.firstWhere((i) => i.id == 'bread'),
      items.firstWhere((i) => i.id == 'bread'),
      items.firstWhere((i) => i.id == 'bread'),
    ];

    if (gameComplete) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _showWinDialog();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Game"),
        actions: [IconButton(onPressed: _resetGame, icon: const Icon(Icons.refresh))],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.blue.shade100, Colors.blue.shade50]),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text("Drag items to your cart!", style: TextStyle(fontSize: 16, color: Colors.black54)),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade200,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 4))],
                        ),
                        child: Column(
                          children: [
                            const Text("Snacks", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            _buildShelf(snackShelf),
                            const SizedBox(height: 16),
                            _buildShelf(middleShelf),
                            const SizedBox(height: 16),
                            _buildShelf(bottomShelf),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.yellow.shade100,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black, width: 3),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Checklist", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
                                const SizedBox(height: 12),
                                _checkItem(label: "🫐 Berry Snacks", id: "berry", need: 1),
                                const SizedBox(height: 8),
                                _checkItem(label: "🍜 Noodle Cup", id: "noodle", need: 2),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          DragTarget<Item>(
                            onAccept: (item) {
                              if (item.onList) {
                                setState(() => cart.add(item));
                                _checkGameComplete();
                              } else {
                                setState(() => wrongItemId = item.id);
                                Future.delayed(const Duration(milliseconds: 1200), () {
                                  if (mounted) setState(() => wrongItemId = null);
                                });
                              }
                            },
                            builder: (context, candidateData, rejectedData) {
                              return Container(
                                padding: const EdgeInsets.all(16),
                                constraints: const BoxConstraints(minHeight: 220),
                                decoration: BoxDecoration(
                                  color: Colors.pink.shade200,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.pink.shade400, width: 3),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        Icon(Icons.shopping_cart, color: Colors.black87),
                                        SizedBox(width: 8),
                                        Text("Shopping Cart", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    cart.isEmpty
                                        ? const Center(child: Padding(padding: EdgeInsets.all(32), child: Text("Drop items here!", style: TextStyle(color: Colors.black54))))
                                        : Wrap(spacing: 8, runSpacing: 8, children: cart.map((item) => _itemBox(item)).toList()),
                                  ],
                                ),
                              );
                            },
                          ),
                          if (wrongItemId != null)
                            Container(
                              margin: const EdgeInsets.only(top: 16),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.red.shade100,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.red.shade400, width: 2),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.cancel, color: Colors.red),
                                  SizedBox(width: 8),
                                  Expanded(child: Text("That's not on the list!", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

