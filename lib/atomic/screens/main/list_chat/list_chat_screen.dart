import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_app/atomic/atoms/chat-item/chat_item_widget.dart';
import 'package:interview_app/atomic/atoms/infinite-list/infinite_list_app.dart';
import 'package:interview_app/local/app_database.dart';
import 'package:interview_app/local/tables/rooms.dart';
import 'package:interview_app/routing/routes.dart';

class ListChatScreen extends StatefulWidget {
  const ListChatScreen({super.key});

  @override
  State<ListChatScreen> createState() => _ListChatScreenState();
}

class _ListChatScreenState extends State<ListChatScreen> {
  List<Rooms> data = [];
  late AppDatabase database;
  late RoomsRepository roomsRepository;
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    database = AppDatabase();
    roomsRepository = RoomsRepository(database);
    getData();
  }

  Future<void> getData() async {
    try {
      final rooms = await roomsRepository.getAllRooms();
      setState(() {
        data = rooms;
        isError = false;
      });
    } catch (e) {
      setState(() {
        isError = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> handleDeleteRoom(Rooms room) async {
    try {
      await roomsRepository.deleteRoom(room.id);
      getData();
    } catch (e) {
      setState(() {
        isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: [
          IconButton(
            onPressed: () {
              context.push(Routes.createChanel);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: InfiniteListApp<Rooms>(
        onRefresh: getData,
        itemBuilder:
            (room, index) =>
                ChatItemWidget(room: room, onDelete: handleDeleteRoom),
        data: data,
        emptyBuilder: EmptyListWidget(),
        isLoading: isLoading,
        isError: isError,
      ),
    );
  }
}

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.chat_bubble_outline, size: 50),
          const SizedBox(height: 16),
          Text(
            'No chats available',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Text(
            'Start a new chat',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          IconButton(
            onPressed: () {
              context.push(Routes.createChanel);
            },
            icon: const Icon(Icons.add_circle_outline, size: 50),
          ),
        ],
      ),
    );
  }
}
