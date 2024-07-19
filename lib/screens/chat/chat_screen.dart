import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/widgets/chat_card.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final email =
        UserController.instance.firebaseUser.value?.providerData[0].email;

    final Stream<QuerySnapshot> messageStream = FirebaseFirestore.instance
        .collection("ChatRooms")
        .where("participants", arrayContainsAny: [email]).snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tin nhắn",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: Container(),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: messageStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
                child: Text("Có lỗi xảy ra. Vui lòng thử lại sau!"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Bạn chưa nhắn tin cho ai!"));
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

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: ChatCard(
                      name: data["name"],
                      emailReceiver: emailReceiver[0],
                      lastMessage: data["lastMessage"],
                      roomId: ds.id,
                      imageUrl: data["avatar"],
                      phone: data["phone"],
                    ),
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
