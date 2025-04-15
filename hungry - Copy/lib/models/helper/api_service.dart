import 'dart:convert';
import 'package:http/http.dart' as http;

class GoogleApiService {
  static const String _apiKey = 'AIzaSyCYrznOpJixj9NQD1rO9Pydq3G8WKFe5q0'; // Replace with your key
  static const String _model = 'models/gemini-pro'; // ✅ Correct model path

  static Future<String> getApiResponse(String message) async {
    final url =
        'https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateContent?key=$_apiKey';

    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      "contents": [
        {
          "parts": [
            {"text": message}
          ]
        }
      ]
    });

    try {
      final response =
      await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final reply = data['candidates'][0]['content']['parts'][0]['text'];
        return reply.trim();
      } else {
        print("Status: ${response.statusCode}");
        print("Body: ${response.body}");
        return "Error: Unable to fetch response from Gemini.";
      }
    } catch (e) {
      print("Exception: $e");
      return "Error: Something went wrong.";
    }
  }
}
