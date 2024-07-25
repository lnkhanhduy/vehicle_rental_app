import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpSearchScreen extends StatefulWidget {
  const HelpSearchScreen({super.key});

  @override
  State<HelpSearchScreen> createState() => _HelpSearchScreenState();
}

class _HelpSearchScreenState extends State<HelpSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_outlined)),
        title: const Text(
          "Hướng dẫn tìm xe",
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
                    "1. Tại 'Trang chủ', nhập từ khóa tìm kiếm.",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Image.asset('lib/assets/images/help/search_screen/home.png'),
                  SizedBox(height: 8),
                  Text(
                    "2. Sau đó ấn biểu tượng tìm kiếm.",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Image.asset('lib/assets/images/help/search_screen/car.png'),
                  SizedBox(height: 8),
                  Text(
                    "3. Hiển thị kết quả tìm kiếm.",
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
