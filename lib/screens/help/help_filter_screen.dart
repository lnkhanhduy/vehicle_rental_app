import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpFilterScreen extends StatefulWidget {
  const HelpFilterScreen({super.key});

  @override
  State<HelpFilterScreen> createState() => _HelpFilterScreenState();
}

class _HelpFilterScreenState extends State<HelpFilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_outlined)),
        title: const Text(
          "Hướng dẫn lọc xe",
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
                    "1. Tại trang tìm xe, chọn biểu tượng lọc xe",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Image.asset('lib/assets/images/help/filter_screen/car.png'),
                  SizedBox(height: 8),
                  Text(
                    "2. Sau đó lọc xe muốn tìm kiếm.",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Image.asset(
                      'lib/assets/images/help/filter_screen/filter.png'),
                  SizedBox(height: 8),
                  Text("3. Hiển thị kết quả đã lọc.",
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
