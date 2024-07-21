import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/admin_controller.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/screens/flash_screen.dart';
import 'package:vehicle_rental_app/widgets/user_card_approve.dart';

class ApproveUserPaperScreen extends StatefulWidget {
  const ApproveUserPaperScreen({super.key});

  @override
  State<ApproveUserPaperScreen> createState() => _ApproveUserPaperScreenState();
}

class _ApproveUserPaperScreenState extends State<ApproveUserPaperScreen> {
  @override
  Widget build(BuildContext context) {
    Get.closeCurrentSnackbar();

    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text(
          "Xét duyệt giấy tờ",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                UserController.instance.logout();
              },
              icon: Icon(Icons.logout_outlined, color: Colors.red))
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<List<UserModel>?>(
        future: AdminController.instance.getUserApproveScreen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return FlashScreen();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Không có giấy tờ cần duyệt'));
          } else {
            List<UserModel> userList = snapshot.data!;
            return Container(
              color: Colors.white,
              child: ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  UserModel user = userList[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                    child: UserCardApprove(
                      user: user,
                      view: true,
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
