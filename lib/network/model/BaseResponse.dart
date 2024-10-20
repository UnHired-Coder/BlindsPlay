import 'dart:convert';

class BaseResponse {
  final String event;
  final dynamic data;

  BaseResponse({required this.event, required this.data});

  // Factory method to create a BaseResponse from JSON
  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      event: json['event'] as String,
      data: json['data'],
    );
  }

  // Method to parse the response into specific event data
  static BaseResponse parseResponse(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return BaseResponse.fromJson(json);
  }
}
