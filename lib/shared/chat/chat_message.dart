import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatMessage {
  final types.Message message;

  ChatMessage({required this.message});
  ChatMessage.fromRoleAndContent({
    required String role,
    required String content,
  }) : message = types.TextMessage(
         author: types.User(id: role),
         id: DateTime.now().millisecondsSinceEpoch.toString(),
         text: content,
         createdAt: DateTime.now().millisecondsSinceEpoch,
       );

  Map<String, dynamic> toJson() => {
    'role': message.author.id,
    'parts': [
      {
        'text':
            message is types.TextMessage
                ? (message as types.TextMessage).text
                : '[Unsupported message type]',
      },
    ],
  };
}
