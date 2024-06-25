import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/admin_controller.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/screens/layout_screen.dart';
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
        leading: IconButton(
            onPressed: () => Get.to(() => const LayoutScreen(initialIndex: 3)),
            icon: const Icon(Icons.arrow_back)),
        title: const Text(
          "Xét duyệt giấy tờ",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<UserModel>?>(
        future: AdminController.instance.getUserApproveScreen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Không có giấy tờ cần duyệt'));
          } else {
            List<UserModel> userList = snapshot.data!;
            return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                UserModel user = userList[index];
                return Column(
                  children: [
                    UserCardApprove(
                      user: user,
                      view: true,
                    ),
                    const Divider(
                      height: 1,
                    )
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
