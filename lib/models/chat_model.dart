import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vehicle_rental_app/models/user_model.dart';

class ChatModel {
  final String? id;
  final String? lastMessage;
  UserModel? user;

  ChatModel({
    this.id,
    this.lastMessage,
    required this.user,
  });

  factory ChatModel.fromFirestore(DocumentSnapshot doc, UserModel user) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatModel(
      id: doc.id,
      lastMessage: data['lastMessage'] as String?,
      user: user,
    );
  }
}
