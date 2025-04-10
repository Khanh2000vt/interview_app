import 'dart:convert';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:http/http.dart' as http;
import 'package:interview_app/constants/app.dart';
import 'package:interview_app/services/router_url.dart';

class GeminiApiClient {
  Future<String> sendMessage(
    List<types.Message> history,
    String newMessage,
  ) async {
    List<types.Message> updatedHistory = List.from(history)..add(
      types.TextMessage(
        author: const types.User(id: 'user'),
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: newMessage,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ),
    );

    Map<String, dynamic> toJsonToChat(types.Message message) => {
      'role': message.author.id,
      'parts': [
        {
          'text':
              message is types.TextMessage
                  ? (message).text
                  : '[Unsupported message type]',
        },
      ],
    };

    String convertResult(String text) {
      if (text == '') {
        return '';
      }
      return text.replaceAll(RegExp(r'\n{2,}'), '\n').trimRight();
    }

    final payload = {
      'contents':
          updatedHistory.reversed.map((msg) => toJsonToChat(msg)).toList(),
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
      return convertResult(responseContent);
    } else {
      throw Exception(
        'Failed to call Gemini API: ${response.statusCode} - ${response.body}',
      );
    }
  }
}
