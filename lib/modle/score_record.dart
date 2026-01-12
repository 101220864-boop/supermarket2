class ScoreRecord {
  final int? id;
  final String playerName;
  final int score;
  final String date;

  ScoreRecord({
    this.id,
    required this.playerName,
    required this.score,
    required this.date,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'playerName': playerName,
    'score': score,
    'date': date,
  };

  factory ScoreRecord.fromMap(Map<String, dynamic> map) {
    return ScoreRecord(
      id: map['id'] as int?,
      playerName: map['playerName'] as String,
      score: map['score'] as int,
      date: map['date'] as String,
    );
  }
}
