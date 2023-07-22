class GameStats {
  final int totalPlay;
  final int totalWin;
  final int totalLoss;

  GameStats({
    required this.totalPlay,
    required this.totalWin,
    required this.totalLoss,
  });

  factory GameStats.fromJson(Map<String, dynamic> json) {
    return GameStats(
      totalPlay: json['totalPlay'] ?? 0,
      totalWin: json['totalWin'] ?? 0,
      totalLoss: json['totalLoss'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalPlay': totalPlay,
      'totalWin': totalWin,
      'totalLoss': totalLoss,
    };
  }
}
