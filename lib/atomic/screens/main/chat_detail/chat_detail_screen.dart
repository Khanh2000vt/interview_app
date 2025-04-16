import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:interview_app/atomic/atoms/text/text_app.dart';
import 'package:interview_app/constants/common.dart';
import 'package:interview_app/firebase/remote_config/remote_config.dart';
import 'package:interview_app/local/app_database.dart';
import 'package:interview_app/local/tables/chats.dart';
import 'package:interview_app/local/tables/rooms.dart';
import 'package:interview_app/routing/routes.dart';
import 'package:interview_app/shared/common/prompt.dart';
import 'package:interview_app/themes/colors.dart';

class ChatDetailScreen extends StatefulWidget {
  final String id;
  const ChatDetailScreen({super.key, required this.id});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final List<types.TextMessage> messages = [];
  final List<types.TextMessage> messagesDraft = [];
  late final GenerativeModel _model;
  late final ChatSession _chat;
  late ChatsRepository chatsRepository;
  late AppDatabase database;

  bool replying = false;
  int page = 1;

  final _user = types.User(id: ChatConstants.user);

  @override
  void initState() {
    super.initState();
    database = AppDatabase();
    chatsRepository = ChatsRepository(database);
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: RemoteConfig().getGeminiKey(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    onGetDataFromDB();
  }

  @override
  void dispose() {
    onSaveListChat();
    super.dispose();
  }

  Future<void> onGetDataFromDB() async {
    try {
      final chats = await chatsRepository.getAllChatsByRoom(widget.id);
      if (chats.isEmpty) {
        onInitStartData();
        return;
      }
      final messagesDB =
          chats
              .map(
                (e) => types.TextMessage(
                  author: types.User(id: e.rule),
                  id: e.id.toString(),
                  text: e.message,
                ),
              )
              .toList();
      setState(() {
        messages.insertAll(0, messagesDB);
      });

      final chatHistory =
          chats.reversed.map((chat) {
            if (chat.rule == ChatConstants.model) {
              return Content.model([TextPart(chat.message)]);
            }
            return Content.text(chat.message);
          }).toList();
      _chat = _model.startChat(history: chatHistory);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Future<void> onInitStartData() async {
    final roomsRepository = RoomsRepository(database);
    final rooms = await roomsRepository.getRoomById(widget.id);
    if (rooms == null) {
      return;
    }
    _chat = _model.startChat();
    final prompt = await PromptAI().getPrompt(rooms.job, rooms.level);
    onChatAi(prompt);
    roomsRepository.updateRoomIsActive(widget.id, true);
  }

  Future<void> onSaveListChat() async {
    final chats =
        messagesDraft.map((e) {
          return ChatsTableCompanion.insert(
            idRoom: widget.id,
            message: e.text,
            rule: e.author.id,
          );
        }).toList();
    await chatsRepository.insertAllChat(chats);
    database.close();
  }

  Future<void> onChatAi(String answer) async {
    final userMessage = types.TextMessage(
      author: _user,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: answer,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    messagesDraft.insert(0, userMessage);
    setState(() {
      messages.insert(0, userMessage);
      replying = true;
    });
    try {
      final response = await _chat.sendMessage(Content.text(answer));
      final modelMessage = types.TextMessage(
        author: types.User(id: ChatConstants.model),
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: response.text ?? 'Lỗi',
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      messagesDraft.insert(0, modelMessage);
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

  void _handleSendPressed(types.PartialText message) {
    onChatAi(message.text);
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
      } else {
        acc.add(item);
      }
      return acc;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filterMessage = filterMessages(messages);
    return Scaffold(
      appBar: AppBar(
        title: TextApp('Phỏng vấn', fontSize: 20, fontWeight: FontWeight.w600),
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).go(Routes.listChat);
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
      ),
      body: Chat(
        messages: filterMessage,
        onSendPressed: _handleSendPressed,
        user: _user,
        onAttachmentPressed: () {},
        onMessageTap: (context, message) {},
        typingIndicatorOptions: TypingIndicatorOptions(
          typingUsers:
              replying
                  ? [
                    types.User(
                      id: ChatConstants.model,
                      firstName: 'Nhà Phỏng vấn',
                    ),
                  ]
                  : [],
        ),
        theme: DefaultChatTheme(
          inputBackgroundColor: Colors.white,
          primaryColor: ColorsApp.primary,
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
              color: ColorsApp.primary,
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
