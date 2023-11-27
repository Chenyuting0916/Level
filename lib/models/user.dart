class MyUser {
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
  final int loginDays;
  final DateTime lastLoginDay;
  final String imageUrl;
  final int weekStudySeconds;
  final int monthStudySeconds;
  final bool premium;

  MyUser(
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
      required this.seconds,
      required this.loginDays,
      required this.lastLoginDay,
      required this.imageUrl,
      required this.weekStudySeconds,
      required this.monthStudySeconds,
      required this.premium});

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "username": username,
      "level": level,
      "exp": exp,
      "strength": strength,
      "wisdom": wisdom,
      "intelligence": intelligence,
      "vitality": vitality,
      "agility": agility,
      "professionalSkill": professionalSkill,
      "luck": luck,
      "financialQuotient": financialQuotient,
      "seconds": seconds,
      "loginDays": loginDays,
      "lastLoginDay": lastLoginDay,
      "imageUrl": imageUrl,
      "monthStudySeconds": monthStudySeconds,
      "weekStudySeconds": weekStudySeconds,
      "premium": premium
    };
  }

  static MyUser fromJson(Map<String, dynamic> json) => MyUser(
      userId: json['userId'] ?? '',
      username: json['username'] ?? '',
      level: json['level'] ?? 0,
      strength: json['strength'] ?? 0,
      wisdom: json['wisdom'] ?? 0,
      intelligence: json['intelligence'] ?? 0,
      vitality: json['vitality'] ?? 0,
      agility: json['agility'] ?? 0,
      professionalSkill: json['professionalSkill'] ?? 0,
      luck: json['luck'] ?? 0,
      financialQuotient: json['financialQuotient'] ?? 10,
      seconds: json['seconds'] ?? 0,
      exp: json['exp'] ?? 1,
      loginDays: json['loginDays'] ?? 1,
      lastLoginDay: json['lastLoginDay']?.toDate() ?? DateTime.now(),
      imageUrl: json['imageUrl'] ?? "",
      weekStudySeconds: json['weekStudySeconds'] ?? 0,
      monthStudySeconds: json['monthStudySeconds'] ?? 0,
      premium: json['premium'] ?? false);

  dynamic getProperty(String key) => <String, dynamic>{
        "userId": userId,
        "username": username,
        "level": level,
        "exp": exp,
        "strength": strength,
        "wisdom": wisdom,
        "intelligence": intelligence,
        "vitality": vitality,
        "agility": agility,
        "professionalSkill": professionalSkill,
        "luck": luck,
        "financialQuotient": financialQuotient,
        "seconds": seconds,
        "loginDays": loginDays,
        "lastLoginDay": lastLoginDay,
        "imageUrl": imageUrl,
        "monthStudySeconds": monthStudySeconds,
        "weekStudySeconds": weekStudySeconds
      }[key];
}
