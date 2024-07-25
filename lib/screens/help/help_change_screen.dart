import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpChangeScreen extends StatefulWidget {
  const HelpChangeScreen({super.key});

  @override
  State<HelpChangeScreen> createState() => _HelpChangeScreenState();
}

class _HelpChangeScreenState extends State<HelpChangeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_outlined)),
        title: const Text(
          "Hướng dẫn đổi thông tin",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "1. Chọn 'Tài khoản'.",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Image.asset(
                      'lib/assets/images/help/profile_screen/account.png'),
                  SizedBox(height: 8),
                  Text(
                    "2. Chọn 'Tài khoản của tôi'.",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Image.asset(
                      'lib/assets/images/help/profile_screen/profile.png'),
                  SizedBox(height: 8),
                  Text(
                    "3. Sửa thông tin.",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
