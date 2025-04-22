import 'dart:convert';

import 'package:http/http.dart' as http;

/*
Service class to handle all Claude API stuff..
*/

class ClaudeApiService {
  // API Constants
  static const String _baseUrl =
      "https://generativelanguage.googleapis.com/v1/models/gemini-1.5-pro:generateContent";
  static const String _apiVersion = '2023-06-01';
  static const String _model = 'claude-3-opus-20240229';
  static const int _maxTokens = 1024;

  // Store the API key securely
  final String _apiKey;

  // Require API key
  ClaudeApiService({required String apiKey})
      : _apiKey = "AIzaSyBYjW08-NFx6MaCrIyMwbfDhCr33ZdLgQY";

  /*
  Send a message to Claude API & return the response
  */
  Future<String> sendMessage(String content) async {
    try {
      // Make POST request to Claude API
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: _getHeaders(),
        body: _getRequestBody(content),
      );

      // Check if request was successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body); // parse json response
        return data['content'][0]['text']; // Extract Claude's response text
      }
      // Handle unsuccessful response
      else {
        throw Exception(
            'Failed to get response from Claude: ${response.statusCode}');
      }
    } catch (e) {
      // handle any errors during api call
      throw Exception('API Error $e');
    }
  }

  // create required headers for Claude API
  Map<String, String> _getHeaders() => {
        'Content-Type': 'application/json',
        'x-api-key': _apiKey,
        'anthropic-version': _apiVersion,
      };

  // format request body according to Claude API specs
  String _getRequestBody(String content) => jsonEncode({
        'model': _model,
        'messages': [
          // format message in Claude's required structure
          {'role': 'user', 'content': content}
        ],
        'max_tokens': _maxTokens,
      });
}
