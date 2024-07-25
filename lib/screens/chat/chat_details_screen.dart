import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/models/chat_model.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/screens/chat/display_message.dart';
import 'package:vehicle_rental_app/utils/constants.dart';

class ChatDetailsScreen extends StatefulWidget {
  final UserModel user;

  const ChatDetailsScreen({super.key, required this.user});

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  final userController = Get.put(UserController());

  final message = TextEditingController();
  late String? chatRoomId = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_outlined)),
        title: Text(
          widget.user.name,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          widget.user.isPublic && widget.user.phone.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    EvaIcons.phoneCallOutline,
                    size: 24,
                  ),
                  onPressed: () async {
                    final Uri url = Uri(
                      scheme: 'tel',
                      path: widget.user.phone,
                    );
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  })
              : SizedBox(),
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<ChatModel?>(
            future: userController.getChatRoom(widget.user.email),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                    color: Colors.white,
                    child: Center(child: CircularProgressIndicator()));
              }
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  ChatModel chatModel = snapshot.data!;
                  chatRoomId = chatModel.id;
                }

                return Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: DisplayMessage(
                          emailReceiver: widget.user.email,
                          chatRoomId: chatRoomId,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: message,
                                onSubmitted: (value) async {
                                  sendMessage();
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    hintText: "Nhập tin nhắn",
                                    hintStyle: TextStyle(fontSize: 15),
                                    enabled: true,
                                    contentPadding: EdgeInsets.only(
                                        left: 15, top: 4, bottom: 4),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Constants.primaryColor),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade50),
                                      borderRadius: BorderRadius.circular(20),
                                    )),
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                final List<XFile>? images =
                                    await ImagePicker().pickMultiImage();
                                List<Uint8List> imageFileList = [];

                                if (images != null && images.isNotEmpty) {
                                  for (var image in images) {
                                    final bytes = await image.readAsBytes();
                                    imageFileList.add(bytes);
                                  }
                                }

                                for (var imageBytes in imageFileList) {
                                  uploadImage(imageBytes);
                                }
                              },
                              icon: Icon(
                                Icons.image_outlined,
                                size: 30,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                sendMessage();
                              },
                              icon: Icon(
                                Icons.send,
                                size: 30,
                                color: Constants.primaryColor,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
              return Container();
            }),
      ),
    );
  }

  Future<void> sendMessage() async {
    if (message.text.trim().isNotEmpty) {
      bool result = await userController.sendMessage(
          message.text.trim(), widget.user.email);

      if (result) {
        message.clear();

        if (chatRoomId == null) {
          final email =
              userController.firebaseUser.value?.providerData[0].email;

          final querySnapshot = await FirebaseFirestore.instance
              .collection("ChatRooms")
              .where("participants",
                  arrayContainsAny: [widget.user.email, email]).get();
          if (querySnapshot.docs.isNotEmpty) {
            setState(() {
              chatRoomId = querySnapshot.docs.first.id;
            });
          }
        }
      }
    }
  }

  Future<void> uploadImage(image) async {
    if (image != null) {
      final email = userController.firebaseUser.value?.providerData[0].email;

      if (chatRoomId == null) {
        await userController.sendMessage("", widget.user.email);

        final querySnapshot = await FirebaseFirestore.instance
            .collection("ChatRooms")
            .where("participants",
                arrayContainsAny: [widget.user.email, email]).get();
        setState(() {
          chatRoomId = querySnapshot.docs.first.id;
        });
      }

      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      // Tải hình ảnh lên Firebase Storage
      await firebase_storage.FirebaseStorage.instance
          .ref('chats/$chatRoomId/$fileName.png')
          .putData(image!);

      // Lấy URL của hình ảnh sau khi tải lên
      String imageUrl = await firebase_storage.FirebaseStorage.instance
          .ref('chats/$chatRoomId/$fileName.png')
          .getDownloadURL();

      // Lưu URL của hình ảnh vào Firestore
      await FirebaseFirestore.instance
          .collection("ChatRooms")
          .doc(chatRoomId)
          .collection("Messages")
          .add({
        "message": imageUrl,
        "emailSender": email,
        "emailReceiver": widget.user.email,
        "time": DateTime.now(),
      });
    }
  }
}
