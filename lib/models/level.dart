class Level {
  final int level;
  late int maxExp = getMaxExp();
  final int currentExp;

  static List levelExpList = [
    5,
    10,
    18,
    22,
    26,
    30,
    34,
    38,
    42,
    46,
    50,
    54,
    58,
    68,
    78,
    100,
    120
  ];

  int getMaxExp() {
    if (level > levelExpList.length - 1) return 120;
    return levelExpList[level - 1];
  }

  Level({required this.level, required this.currentExp});
}
