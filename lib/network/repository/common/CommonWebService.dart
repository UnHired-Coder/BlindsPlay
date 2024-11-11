import 'dart:convert';

import 'package:blindsplay/network/model/GameUser.dart';
import 'package:http/http.dart' as http;

class CommonWebService {
  final String baseUrl;

  CommonWebService({required this.baseUrl});

  Future<List<GameUser>> getLeaderboard() async {
    final url = Uri.parse('$baseUrl/common/leaderboard');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch leaderboard: ${response.reasonPhrase}');
    }

    final Map<String, dynamic> responseData = jsonDecode(response.body);
    return (responseData['leaderboard'] as List<dynamic>)
        .map((user) => GameUser.fromJson(user))
        .toList();
  }
}
