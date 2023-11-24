import 'package:level/models/user.dart';

class SelfRankViewModel {
  final int rank;
  final String category;
  final MyUser self;

  SelfRankViewModel({required this.rank, required this.category, required this.self});
}
