import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/screens/loading_screen.dart';
import 'package:vehicle_rental_app/widgets/chat_card.dart';

class ChatScreen extends StatefulWidget {
  final bool isAdmin;

  const ChatScreen({Key? key, this.isAdmin = false}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final userController = Get.put(UserController());

  final email =
      UserController.instance.firebaseUser.value?.providerData[0].email;

  final firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tin nhắn",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Container(),
        actions: [
          widget.isAdmin
              ? IconButton(
                  onPressed: () {
                    userController.logout();
                  },
                  icon: Icon(Icons.logout_outlined, color: Colors.red),
                )
              : Container(),
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firebaseFirestore
            .collection("ChatRooms")
            .where("participants", arrayContainsAny: [email]).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
                child: Text("Có lỗi xảy ra. Vui lòng thử lại sau!"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreen();
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Container(
              color: Colors.white,
              child: Center(child: Text("Bạn chưa nhắn tin cho ai.")),
            );
          }

          return Container(
            color: Colors.white,
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data!.docs[index];
                Map<String, dynamic>? data = ds.data() as Map<String, dynamic>?;

                if (data != null) {
                  List<String> participants =
                      (data["participants"] as List<dynamic>).cast<String>();
                  List<String> emailReceiver =
                      participants.where((value) => value != email).toList();

                  if (emailReceiver.isEmpty) {
                    return null;
                  }

                  return FutureBuilder<UserModel?>(
                    future: userController.getUserByUsername(emailReceiver[0]),
                    builder: (context, userSnapshot) {
                      if (userSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return SizedBox.shrink();
                      }

                      if (userSnapshot.hasError || !userSnapshot.hasData) {
                        return ListTile(
                          title: Text("Error loading user"),
                        );
                      }

                      UserModel? user = userSnapshot.data;

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: ChatCard(
                          lastMessage: data["lastMessage"] ?? "",
                          roomId: ds.id,
                          user: user!,
                        ),
                      );
                    },
                  );
                }

                return null;
              },
            ),
          );
        },
      ),
    );
  }
}
