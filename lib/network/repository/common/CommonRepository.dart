import 'package:blindsplay/network/model/GameUser.dart';

import 'CommonWebService.dart';

class CommonRepository {
  final CommonWebService commonWebService;

  CommonRepository({required this.commonWebService});

  Future<List<GameUser>> getLeaderboard() async {
    return commonWebService.getLeaderboard();
  }
}
