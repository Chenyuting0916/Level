import 'dart:math';

import 'package:level/models/category.dart';
import 'package:level/models/level.dart';
import 'package:level/models/user.dart';
import 'package:level/services/user_service.dart';

class StatusService {
  Future<User> updateStatus(int categoryId, int learningSeconds) async {
    User? oldUser = await UserService().getCurrentUser();

    Map<String, dynamic> updatedData = {};
    if (learningSeconds >= 600) {
      updatedData
          .addEntries(updateStatusByCategory(categoryId, oldUser).entries);
      updatedData["seconds"] = oldUser!.seconds + learningSeconds;
    }
    updatedData.addEntries(levelUp(oldUser!, learningSeconds).entries);
    UserService().updateUser(updatedData);

    return oldUser;
  }

  Map<String, int> levelUp(User user, int learningSeconds) {
    int maxExp = Level(level: user.level, currentExp: user.exp).maxExp;
    int addExp = getAddExp(learningSeconds);
    if (addExp + user.exp >= maxExp) {
      return {"level": user.level + 1, "exp": addExp + user.exp - maxExp};
    }
    return {"exp": addExp + user.exp};
  }

  Map<String, int> updateStatusByCategory(int categoryId, User? user) {
    if (user == null) return {};
    Map<String, int> results = {};
    switch (Category.getCategoryEnum(categoryId)) {
      case CategoryName.exercises:
        results.addEntries({
          "strength": user.strength + 3,
          "vitality": user.vitality + 5,
          "agility": user.agility + 2
        }.entries);
        break;
      case CategoryName.study:
        results.addEntries({
          "wisdom": user.wisdom + 3,
          "intelligence": user.intelligence + 5,
          "professionalSkill": user.professionalSkill + 2
        }.entries);
        break;
      case CategoryName.mindfulness:
        results.addEntries({
          "agility": user.agility + 3,
          "wisdom": user.wisdom + 5,
          "vitality": user.vitality + 2
        }.entries);
        break;
      case CategoryName.art:
        results.addEntries({
          "wisdom": user.wisdom + 1,
          "intelligence": user.intelligence + 3,
          "professionalSkill": user.professionalSkill + 5,
        }.entries);
        break;
      case CategoryName.work:
        results.addEntries(
            {"professionalSkill": user.professionalSkill + 7}.entries);
        break;
      case CategoryName.code:
        results.addEntries(
            {"professionalSkill": user.professionalSkill + 5}.entries);
        break;
      case CategoryName.learnLanguage:
        results.addEntries({
          "intelligence": user.intelligence + 3,
          "professionalSkill": user.professionalSkill + 5
        }.entries);
        break;
      case CategoryName.startABusiness:
        results.addEntries({
          "agility": user.agility + 3,
          "financialQuotient": user.financialQuotient + 5,
          "wisdom": user.wisdom + 2
        }.entries);
        break;
      case CategoryName.financialLiteracy:
        results.addEntries({
          "intelligence": user.intelligence + 3,
          "financialQuotient": user.financialQuotient + 7,
          "wisdom": user.wisdom + 1
        }.entries);
        break;
      default:
        return {};
    }

    if (Random().nextInt(1000) > 500) {
      results.addEntries({"luck": user.luck + 1}.entries);
    }

    return results;
  }

  int getAddExp(int learningSeconds) {
    int addExp = ((learningSeconds / 1800.0) * 10).toInt();
    return addExp >= 10 ? 10 : addExp;
  }

  Future<double> getBiggestStatus() async {
    var user = await UserService().getCurrentUser();
    var allStatus = [
      user!.agility,
      user.strength,
      user.intelligence,
      user.wisdom,
      user.vitality,
      user.professionalSkill,
      user.luck,
      user.financialQuotient
    ];

    return allStatus.reduce(max).toDouble();
  }
}
