import 'package:level/models/category.dart';
import 'package:level/models/user.dart';
import 'package:level/services/user_service.dart';

class StatusService {

  void updateStatus(int categoryId, int learningSeconds) async {
    User? user = await UserService().getCurrentUser();

    dynamic update = updateStatusByCategory(categoryId, user);
    UserService().updateUser(update);

    //calculate if need levelup
    LevelUp();
  }

  void LevelUp() {}

  Map<String, int> updateStatusByCategory(int categoryId, User? user) {
    if (user == null) return {};
    switch (Category.getCategoryEnum(categoryId)) {
      case CategoryName.exercises:
        return {
          "strength": user.strength + 3,
          "vitality": user.vitality + 5,
          "agility": user.agility + 2
        };
      case CategoryName.study:
        return {
          "wisdom": user.wisdom + 3,
          "intelligence": user.intelligence + 5,
          "professionalSkill": user.professionalSkill + 2
        };
      case CategoryName.mindfulness:
        return {
          "agility": user.agility + 3,
          "wisdom": user.wisdom + 5,
          "vitality": user.vitality + 2
        };
      case CategoryName.art:
        return {
          "intelligence": user.intelligence + 3,
          "professionalSkill": user.professionalSkill + 5,
        };
      case CategoryName.work:
        return {"professionalSkill": user.professionalSkill + 7};
      case CategoryName.code:
        return {"professionalSkill": user.professionalSkill + 5};
      case CategoryName.learnLanguage:
        return {
          "intelligence": user.intelligence + 3,
          "professionalSkill": user.professionalSkill + 5
        };
      case CategoryName.startABusiness:
        return {
          "agility": user.agility + 3,
          "financialQuotient": user.financialQuotient + 5,
          "wisdom": user.wisdom + 2
        };
      case CategoryName.financialLiteracy:
        return {
          "intelligence": user.intelligence + 3,
          "financialQuotient": user.financialQuotient + 7,
          "wisdom": user.wisdom + 1
        };
      default:
        return {};
    }
  }
}
