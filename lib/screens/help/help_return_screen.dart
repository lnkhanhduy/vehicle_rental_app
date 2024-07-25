import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpReturnScreen extends StatefulWidget {
  const HelpReturnScreen({super.key});

  @override
  State<HelpReturnScreen> createState() => _HelpReturnScreenState();
}

class _HelpReturnScreenState extends State<HelpReturnScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_outlined)),
        title: const Text(
          "Hướng dẫn trả xe/hủy chuyến",
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
                    "1. Chọn 'Lịch sử'.",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Image.asset(
                      'lib/assets/images/help/return_screen/history.png'),
                  SizedBox(height: 8),
                  Text(
                    "2. Sau đó xe muốn trả xe/hủy chuyến.",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "3. Nếu trả xe chọn 'Đánh giá'.",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Image.asset(
                      'lib/assets/images/help/return_screen/rating.png'),
                  SizedBox(height: 8),
                  Text(
                    "3. Nếu hủy chuyến chọn 'Hủy thuê'.",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Image.asset(
                      'lib/assets/images/help/return_screen/reject.png'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
