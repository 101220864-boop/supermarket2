import 'package:flutter/material.dart';
import '../data/app_db.dart';

import '../modle/score_record.dart';
import '../widget/app_drawer.dart';


class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<ScoreRecord>> _future;

  @override
  void initState() {
    super.initState();
    _future = AppDb.instance.getScores();
  }

  void _refresh() {
    setState(() {
      _future = AppDb.instance.getScores();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("History"),
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
      ),
      body: FutureBuilder<List<ScoreRecord>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error:\n${snapshot.error}", textAlign: TextAlign.center),
            );
          }

          final scores = snapshot.data ?? [];
          if (scores.isEmpty) {
            return const Center(child: Text("No history yet"));
          }

          return ListView.builder(
            itemCount: scores.length,
            itemBuilder: (context, i) {
              final s = scores[i];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: const Icon(Icons.star),
                  title: Text("${s.playerName}  —  ${s.score}", style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("Date: ${s.date}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await AppDb.instance.deleteScore(s.id!);
                      _refresh();
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
