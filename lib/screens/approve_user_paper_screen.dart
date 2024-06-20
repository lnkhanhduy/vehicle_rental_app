import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/models/user_model.dart';

class ApproveUserPaperScreen extends StatefulWidget {
  final UserModel user;

  const ApproveUserPaperScreen({super.key, required this.user});

  @override
  State<ApproveUserPaperScreen> createState() => _ApproveUserPaperScreenState();
}

class _ApproveUserPaperScreenState extends State<ApproveUserPaperScreen> {
  @override
  Widget build(BuildContext context) {
    Get.closeCurrentSnackbar();
    return Scaffold(
        appBar: AppBar(
          leading:
              IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
          title: const Text(
            "Duyệt thông tin người dùng",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                  constraints: const BoxConstraints.expand(),
                  color: Colors.white,
                  child: Column(
                    children: [Text("data")],
                  )))
        ]));
  }
}
