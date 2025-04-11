import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:interview_app/constants/common.dart';
import 'package:interview_app/firebase/remote_config/remote_config.dart';
import 'package:interview_app/services/gemini.dart';
import 'package:interview_app/shared/common/prompt.dart';

class ChatDetailModel extends ChangeNotifier {
  final GeminiApiClient apiClient = GeminiApiClient();
  final List<types.Message> _messages = [];
  final _user = types.User(id: ChatConstants.user);

  late final GenerativeModel _model;
  late final ChatSession _chat;

  bool _replying = true;

  List<types.Message> get messages => _messages;
  types.User get user => _user;
  bool get replying => _replying;

  ChatDetailModel() {
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: RemoteConfig().getGeminiKey(),
    );
    _chat = _model.startChat();
  }

  Future<void> startInitialPrompt(BuildContext context) async {
    final prompt = PromptAI().getPrompt(context);
    await onChatAi(prompt);
  }

  Future<void> onChatAi(String answer) async {
    final userMessage = types.TextMessage(
      author: _user,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: answer,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    _replying = true;
    _messages.insert(0, userMessage);
    notifyListeners();
    try {
      final response = await _chat.sendMessage(Content.text(answer));
      final modelMessage = types.TextMessage(
        author: types.User(id: ChatConstants.model),
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: response.text ?? 'Lỗi',
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      _messages.insert(0, modelMessage);
    } catch (e) {
      rethrow;
    } finally {
      _replying = false;
      notifyListeners();
    }
  }

  void onSendPressed(types.PartialText message) {
    onChatAi(message.text);
  }

  List<types.Message> getFilteredMessages() {
    return _messages.asMap().entries.fold([], (acc, entry) {
      final index = entry.key;
      final item = entry.value;
      if (index == _messages.length - 1) {
        acc.add(
          types.TextMessage(
            author: item.author,
            id: item.id,
            text: 'Xin chào!',
            createdAt: item.createdAt,
          ),
        );
      } else {
        acc.add(item);
      }
      return acc;
    });
  }
}
