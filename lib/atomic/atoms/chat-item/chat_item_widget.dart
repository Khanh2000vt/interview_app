import 'package:flutter/material.dart';
import 'package:interview_app/services/list_chat.dart';

class ChatItemWidget extends StatelessWidget {
  const ChatItemWidget({super.key, required this.post});

  final ChatItemList post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      leading: Text('${post.id}', style: textTheme.bodySmall),
      title: Text(post.title),
      isThreeLine: true,
      subtitle: Text(post.body),
      dense: true,
    );
  }
}
