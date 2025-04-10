import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:interview_app/constants/app.dart';
import 'package:interview_app/constants/common.dart';
import 'package:interview_app/enums/common.dart';
import 'package:interview_app/services/gemini.dart';
import 'package:interview_app/shared/common/prompt.dart';
import 'package:interview_app/themes/colors.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final GeminiApiClient apiClient = GeminiApiClient();
  final List<types.Message> messages = [];
  late final GenerativeModel _model;
  late final ChatSession _chat;

  bool replying = true;
  ETurnChat turn = ETurnChat.start;

  final _user = const types.User(id: 'user');

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: AppConstants.keyGemini,
    );
    _chat = _model.startChat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final prompt = PromptAI().getPrompt(context);
    // onChatGemini(prompt);
    onChatGemini2(prompt);
  }

  Future<void> onChatGemini2(String answer) async {
    final userMessage = types.TextMessage(
      author: _user,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: answer,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    setState(() {
      messages.insert(0, userMessage);
      replying = true;
    });

    try {
      final response = await _chat.sendMessage(Content.text(answer));

      final modelMessage = types.TextMessage(
        author: const types.User(id: 'model'),
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: response.text ?? 'Lỗi',
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      setState(() {
        messages.insert(0, modelMessage);
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() {
        replying = false;
      });
    }
  }

  Future<void> onChatGemini(String answer) async {
    try {
      final userMessage = types.TextMessage(
        author: _user,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: answer,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      setState(() {
        messages.insert(0, userMessage);
        replying = true;
      });

      final response = await apiClient.sendMessage(messages, answer);
      onChangeTurn();
      final modelMessage = types.TextMessage(
        author: const types.User(id: 'model'),
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: response,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      setState(() {
        messages.insert(0, modelMessage);
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() {
        replying = false;
      });
      if (turn == ETurnChat.answer) {
        onChatGemini(ChatConstants.start);
      } else {}
    }
  }

  void onChangeTurn() {
    switch (turn) {
      case ETurnChat.start:
      case ETurnChat.answer:
        turn = ETurnChat.question;
      case ETurnChat.question:
        turn = ETurnChat.answer;
    }
  }

  void _handleSendPressed(types.PartialText message) {
    onChatGemini2(message.text);
  }

  List<types.Message> filterMessages(List<types.Message> messages) {
    return messages.asMap().entries.fold([], (acc, entry) {
      int index = entry.key;
      types.Message item = entry.value;
      bool isLast = index == messages.length - 1;
      if (isLast) {
        final userMessage = types.TextMessage(
          author: item.author,
          id: item.id,
          text: 'Xin chào!',
          createdAt: item.createdAt,
        );
        acc.add(userMessage);
      } else if (item is types.TextMessage &&
          item.text != ChatConstants.start) {
        acc.add(item);
      }
      return acc;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filterMessage = filterMessages(messages);
    return Scaffold(
      body: Chat(
        messages: filterMessage,
        onSendPressed: _handleSendPressed,
        user: _user,
        onAttachmentPressed: () {},
        onMessageTap: (context, message) {},
        typingIndicatorOptions: TypingIndicatorOptions(
          typingUsers:
              replying
                  ? [types.User(id: 'model', firstName: 'Nhà Phỏng vấn')]
                  : [],
        ),
        theme: DefaultChatTheme(
          inputBackgroundColor: Colors.white, // Màu nền ô nhập liệu
          primaryColor: ColorsApp.primary, // Màu chính của bong bóng tin nhắn
          secondaryColor: ColorsApp.secondary,
          inputBorderRadius: BorderRadius.all(Radius.zero),
          inputTextColor: Colors.black,
          inputTextDecoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[100],
          ),
          attachmentButtonIcon: Container(
            decoration: BoxDecoration(
              color: ColorsApp.primary, // Màu nền của nút gửi
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(8.0),
            child: const Icon(Icons.mic, color: Colors.white),
          ),
          sendButtonIcon: Icon(Icons.send, color: ColorsApp.primary),
          attachmentButtonMargin: EdgeInsets.all(0),
          sendButtonMargin: EdgeInsets.all(0),
        ),
      ),
    );
  }
}
