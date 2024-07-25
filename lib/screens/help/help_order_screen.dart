import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpOrderScreen extends StatefulWidget {
  const HelpOrderScreen({super.key});

  @override
  State<HelpOrderScreen> createState() => _HelpOrderScreenState();
}

class _HelpOrderScreenState extends State<HelpOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_outlined)),
        title: const Text(
          "Hướng dẫn đặt xe",
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
                    "1. Người dùng chọn xe muốn thuê",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Image.asset('lib/assets/images/help/order_screen/car.png'),
                  SizedBox(height: 8),
                  Text(
                    "2. Sau đó chọn 'Ngày thuê' và 'Ngày trả'",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "3. Chọn 'Thuê xe'",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Image.asset('lib/assets/images/help/order_screen/info.png'),
                  SizedBox(height: 8),
                  Text("3. Nhập lời nhắn cho chủ xe nếu có",
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
