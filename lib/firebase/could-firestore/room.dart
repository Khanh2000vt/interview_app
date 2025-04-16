import 'package:cloud_firestore/cloud_firestore.dart';

class RoomFirestore {
  final userId = 'khanh-macro';
  final CollectionReference firestore = FirebaseFirestore.instance.collection(
    'rooms',
  );

  Future<void> createRoom(String roomId, Map<String, dynamic> data) async {
    try {
      final roomRef =
          FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('rooms')
              .doc();

      await roomRef.set({...data, 'createdAt': FieldValue.serverTimestamp()});
    } catch (e) {
      print('error: $e');
    }
  }

  Future<Map<String, dynamic>> getRoomById(String roomId) async {
    final data =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('rooms')
            .doc(roomId)
            .get();
    return data.data() ?? {};
  }

  Future<void> sendMessageToRoom({
    required String roomId,
    required String senderId,
    required String text,
  }) async {
    final messageRef =
        FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('rooms')
            .doc(roomId)
            .collection('messages')
            .doc(); // Auto ID

    await messageRef.set({
      'text': text,
      'senderId': senderId,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
