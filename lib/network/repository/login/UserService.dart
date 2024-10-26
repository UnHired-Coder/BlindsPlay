import 'dart:convert';

import 'package:blindsplay/network/model/GameUser.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String baseUrl;

  UserService({required this.baseUrl});

  Future<GameUser> loginUser({
    required String userId,
    required String name,
    required String email,
    required String authType,
  }) async {
    final url = Uri.parse('$baseUrl/common/login');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'UserID': userId,
        'Name': name,
        'Email': email,
        'AuthType': authType,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to log in user: ${response.reasonPhrase}');
    }

    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final userJson = responseData['user'] as Map<String, dynamic>;
    return GameUser.fromJson(userJson);
  }
}
