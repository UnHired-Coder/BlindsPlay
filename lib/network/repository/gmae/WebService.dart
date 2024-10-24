import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/MatchingStartedData.dart';

class WebService {
  final String baseUrl;

  WebService({required this.baseUrl});

  // Method to find a match by user ID.
  Future<MatchingStartedData> findMatch(String userId) async {
    final uri = Uri.parse('$baseUrl/tictacmemo/find-match')
        .replace(queryParameters: {'user_id': userId.toString()});

    final response = await http.post(uri);

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      if (decodedResponse is Map<String, dynamic>) {
        if (decodedResponse.containsKey('data')) {
          final data = decodedResponse['data'];
          return MatchingStartedData.fromJson(data);
        } else {
          throw Exception('Response does not contain "data" key.');
        }
      } else {
        throw Exception('Invalid response format: Expected a JSON object.');
      }
    } else {
      throw Exception('Failed to find match: ${response.reasonPhrase}');
    }
  }
}
