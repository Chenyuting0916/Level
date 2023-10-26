class User {
  final String? userId;
  final String username;
  final int level;
  final int exp;
  final int strength;
  final int wisdom;
  final int intelligence;
  final int vitality;
  final int agility;
  final int professionalSkill;
  final int luck;
  final int financialQuotient;
  final int seconds;

  User(
      {required this.userId,
      required this.username,
      required this.level,
      required this.exp,
      required this.strength,
      required this.wisdom,
      required this.intelligence,
      required this.vitality,
      required this.agility,
      required this.professionalSkill,
      required this.luck,
      required this.financialQuotient,
      required this.seconds});

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "username": username,
      "level": level,
      "exp" : exp,
      "strength": strength,
      "wisdom": wisdom,
      "intelligence": intelligence,
      "vitality": vitality,
      "agility": agility,
      "professionalSkill": professionalSkill,
      "luck": luck,
      "financialQuotient": financialQuotient,
      "seconds": seconds,
    };
  }

    static User fromJson(Map<String, dynamic> json) => User(
      userId: json['userId'],
      username: json['username'],
      level: json['level'],
      strength: json['strength'],
      wisdom: json['wisdom'],
      intelligence: json['intelligence'],
      vitality: json['vitality'],
      agility: json['agility'],
      professionalSkill: json['professionalSkill'],
      luck: json['luck'],
      financialQuotient: json['financialQuotient'],
      seconds: json['seconds'], 
      exp: json['exp'],);
}
