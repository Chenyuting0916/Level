import 'package:flutter/material.dart';

class Category {
  static final all = [
    Category(
        id: 1,
        name: 'Exercises',
        icon: const Icon(Icons.directions_walk_sharp)),
    Category(id: 2, name: 'Study', icon: const Icon(Icons.school)),
    Category(
        id: 3,
        name: 'Mindfulness',
        icon: const Icon(Icons.terrain_rounded)),
    Category(id: 4, name: 'Art', icon: const Icon(Icons.bubble_chart)),
    Category(
        id: 5,
        name: 'Work',
        icon: const Icon(Icons.attach_money_rounded)),
    Category(id: 6, name: 'Code', icon: const Icon(Icons.code)),
    Category(
        id: 7, name: 'LearnLanguage', icon: const Icon(Icons.language)),
    Category(
        id: 8,
        name: 'StartABusiness',
        icon: const Icon(Icons.business_sharp)),
    Category(
        id: 9,
        name: 'FinancialLiteracy',
        icon: const Icon(Icons.credit_card)),
  ];

  final int id;
  final String name;
  final Icon icon;

  Category({required this.id, required this.name, required this.icon});

  static final Map<int, CategoryName> _map = {
    1: CategoryName.exercises,
    2: CategoryName.study,
    3: CategoryName.mindfulness,
    4: CategoryName.art,
    5: CategoryName.work,
    6: CategoryName.code,
    7: CategoryName.learnLanguage,
    8: CategoryName.startABusiness,
    9: CategoryName.financialLiteracy
  };

  static CategoryName? getCategoryEnum(int id) {
    return _map[id];
  }
}

enum CategoryName {
  exercises,
  study,
  mindfulness,
  art,
  work,
  code,
  learnLanguage,
  startABusiness,
  financialLiteracy
}
