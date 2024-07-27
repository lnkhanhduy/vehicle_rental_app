import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/screens/chat/chat_details_screen.dart';

class ChatCard extends StatefulWidget {
  final String lastMessage;
  final String roomId;
  final UserModel user;

  ChatCard(
      {super.key,
      required this.lastMessage,
      required this.roomId,
      required this.user});

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
            () => ChatDetailsScreen(user: widget.user, roomId: widget.roomId));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Stack(children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: widget.user.imageAvatar != null &&
                                widget.user.imageAvatar!.isNotEmpty
                            ? Image.network(
                                widget.user.imageAvatar!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                  "lib/assets/images/no_avatar.png",
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Image.asset(
                                "lib/assets/images/no_avatar.png",
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ]),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.user.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                      Text(
                        widget.lastMessage,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
