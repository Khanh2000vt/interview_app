import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as httpClient;
import 'package:interview_app/atomic/atoms/chat-item/chat_item_widget.dart';
import 'package:interview_app/atomic/atoms/infinite-list/infinite_list_app.dart';
import 'package:interview_app/bloc/infinite_list/infinite_list_bloc.dart';
import 'package:interview_app/services/list_chat.dart';

class ListChatScreen extends StatelessWidget {
  const ListChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final infiniteListBloc = InfiniteListBloc(fetchData: fetchPosts);
    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: BlocProvider.value(
        value: infiniteListBloc,
        child: Builder(
          builder: (context) {
            return InfiniteListApp(
              itemBuilder: (product, index) => ChatItemWidget(post: product),
              bloc: infiniteListBloc,
            );
          },
        ),
      ),
    );
  }
}

Future<List<dynamic>> fetchPosts(int startIndex, int postLimit) async {
  print('fetchPosts');
  final response = await httpClient.get(
    Uri.https('jsonplaceholder.typicode.com', '/posts', <String, String>{
      '_start': '$startIndex',
      '_limit': '$postLimit',
    }),
  );
  if (response.statusCode == 200) {
    final body = json.decode(response.body) as List;
    return body.map((dynamic json) {
      final map = json as Map<String, dynamic>;
      return ChatItemList(
        id: map['id'] as int,
        title: map['title'] as String,
        body: map['body'] as String,
      );
    }).toList();
  }
  throw Exception('error fetching posts');
}
