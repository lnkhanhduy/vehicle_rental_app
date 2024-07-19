import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String? id;
  final String? avatar;
  final String? lastMessage;
  final String? name;
  final String? phone;

  const ChatModel({
    this.id,
    this.avatar,
    this.lastMessage,
    this.name,
    this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'avatar': avatar,
      'lastMessage': lastMessage,
      'name': name,
      'phone': phone,
    };
  }

  factory ChatModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    {
      return ChatModel(
        id: snapshot.id,
        avatar: data['avatar'],
        lastMessage: data['lastMessage'],
        name: data['name'],
        phone: data['phone'],
      );
    }
  }
}
