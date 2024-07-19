import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/screens/chat/chat_details_screen.dart';

class ChatCard extends StatefulWidget {
  final String name;
  final String emailReceiver;
  final String lastMessage;
  final String roomId;
  final String? imageUrl;
  final String? phone;

  const ChatCard(
      {super.key,
      required this.name,
      required this.emailReceiver,
      required this.lastMessage,
      required this.roomId,
      this.imageUrl,
      this.phone});

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.to(() => ChatDetailsScreen(
                emailReceiver: widget.emailReceiver,
                name: widget.name,
                phone: widget.phone,
              ));
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
                          child: widget.imageUrl != null &&
                                  widget.imageUrl!.isNotEmpty
                              ? Image.network(widget.imageUrl!)
                              : Image.asset("lib/assets/images/no_avatar.png"),
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                      Text(
                        widget.lastMessage,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }
}
