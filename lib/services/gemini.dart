import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:interview_app/constants/app.dart';
import 'package:interview_app/services/router_url.dart';
import 'package:interview_app/shared/chat/chat_message.dart';

class GeminiApiClient {
  Future<String> sendMessage(
    List<ChatMessage> history,
    String newMessage,
  ) async {
    List<ChatMessage> updatedHistory = List.from(history)
      ..add(ChatMessage(role: 'user', content: newMessage));

    final payload = {
      'contents': updatedHistory.map((msg) => msg.toJson()).toList(),
    };

    final response = await http.post(
      Uri.parse(
        '${AppConstants.baseUrlGemini}${RouterUrl.geminiFlash}?key=${AppConstants.keyGemini}',
      ),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final responseContent =
          data['candidates'][0]['content']['parts'][0]['text'] as String;
      return responseContent;
    } else {
      throw Exception(
        'Failed to call Gemini API: ${response.statusCode} - ${response.body}',
      );
    }
  }
}
