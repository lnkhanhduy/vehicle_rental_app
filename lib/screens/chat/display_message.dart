import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/screens/loading_screen.dart';

class DisplayMessage extends StatefulWidget {
  final String? chatRoomId;
  final String emailReceiver;

  const DisplayMessage(
      {super.key, required this.emailReceiver, this.chatRoomId});

  @override
  State<DisplayMessage> createState() => _DisplayMessageState();
}

class _DisplayMessageState extends State<DisplayMessage> {
  final userController = Get.put(UserController());
  final ScrollController _scrollController = ScrollController();

  final firebaseFirestore = FirebaseFirestore.instance;

  int messageLimit = 10;
  final int messageIncrement = 10;

  @override
  Widget build(BuildContext context) {
    final email = userController.firebaseUser.value?.providerData[0].email;

    return StreamBuilder(
      stream: firebaseFirestore
          .collection("ChatRooms")
          .doc(widget.chatRoomId)
          .collection("Messages")
          .orderBy("time", descending: true)
          .limit(messageLimit)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Có lỗi xảy ra. Vui lòng thử lại sau!");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingScreen();
        }
        return Column(children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              controller: _scrollController,
              itemCount: snapshot.data!.docs.length + 1,
              itemBuilder: (context, index) {
                if (index == snapshot.data!.docs.length) {
                  if (snapshot.data!.docs.length >= messageLimit) {
                    return TextButton(
                      onPressed: () {
                        setState(() {
                          messageLimit += messageIncrement;
                        });
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (_scrollController.hasClients) {
                            _scrollController.animateTo(
                              _scrollController.position.minScrollExtent,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          }
                        });
                      },
                      child: Text("Xem thêm"),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                }
                QueryDocumentSnapshot documentSnapshot =
                    snapshot.data!.docs[index];
                DateTime dateTime = documentSnapshot['time'].toDate();

                return Column(
                  crossAxisAlignment: email == documentSnapshot['emailSender']
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: 250),
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: email == documentSnapshot['emailSender']
                            ? Colors.blueAccent
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            documentSnapshot["message"].startsWith(
                                    "https://firebasestorage.googleapis.com/")
                                ? Image.network(documentSnapshot['message'],
                                    errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      "lib/assets/images/no_image.png",
                                      fit: BoxFit.cover,
                                    );
                                  })
                                : Text(
                                    documentSnapshot['message'],
                                    style: TextStyle(
                                        color: email ==
                                                documentSnapshot['emailSender']
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                            SizedBox(height: 4),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "${dateTime.hour}:${dateTime.minute}",
                                style: TextStyle(
                                  color:
                                      email == documentSnapshot['emailSender']
                                          ? Colors.white
                                          : Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            )
                          ]),
                    ),
                  ],
                );
              },
            ),
          )
        ]);
      },
    );
  }
}
