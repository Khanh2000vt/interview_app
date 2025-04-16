import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_app/local/app_database.dart';
import 'package:interview_app/routing/routes.dart';

class ChatItemWidget extends StatelessWidget {
  const ChatItemWidget({super.key, required this.room, required this.onDelete});

  final Rooms room;
  final void Function(Rooms room)? onDelete;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(room.id.toString()),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),

      onDismissed: (direction) {
        onDelete?.call(room);
      },

      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Confirm Delete'),
              content: Text('Are you sure you want to delete this room?'),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  child: Text('Delete'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: TextButton(
          onPressed: () {
            context.push('${Routes.chatDetail}/${room.id}');
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
          child: ListTile(
            title: Text(room.job, style: textTheme.titleMedium),
            isThreeLine: true,
            subtitle: Text(room.level, style: textTheme.bodySmall),
            dense: true,
          ),
        ),
      ),
    );
  }
}
