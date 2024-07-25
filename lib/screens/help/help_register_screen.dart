import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpRegisterScreen extends StatefulWidget {
  const HelpRegisterScreen({super.key});

  @override
  State<HelpRegisterScreen> createState() => _HelpRegisterScreenState();
}

class _HelpRegisterScreenState extends State<HelpRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_outlined)),
        title: const Text(
          "Hướng dẫn đăng ký xe",
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
                    "1. Người dùng chọn 'Tài khoản'",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Image.asset(
                      'lib/assets/images/help/register_screen/account.png'),
                  SizedBox(height: 8),
                  Text(
                    "2. Sau đó chọn 'Đăng ký cho thuê xe'",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Image.asset(
                      'lib/assets/images/help/register_screen/register.png'),
                  SizedBox(height: 8),
                  Text("3. Điền các thông tin về xe được yêu cầu",
                      style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
