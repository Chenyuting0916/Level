class Level {
  final int level;
  final int maxExp;
  final int currentExp;

  List levelExpList = [
    10,
    14,
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
  Level({required this.level, required this.maxExp, required this.currentExp});
}
