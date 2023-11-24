import 'package:level/models/self_rank.dart';
import 'package:level/services/user_service.dart';

class SelfRankService {
  final UserService _userService = UserService();

  Future<SelfRankViewModel> getSelfRankViewModel(String filter) async {
    var self = await _userService.getCurrentUser();
    var rank = await _userService.getSelfRank(filter);

    return SelfRankViewModel(rank: rank, category: filter, self: self!);
  }
}
