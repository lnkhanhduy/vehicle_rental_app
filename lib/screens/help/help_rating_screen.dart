import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpRatingScreen extends StatefulWidget {
  const HelpRatingScreen({super.key});

  @override
  State<HelpRatingScreen> createState() => _HelpRatingScreenState();
}

class _HelpRatingScreenState extends State<HelpRatingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_outlined)),
        title: const Text(
          "Hướng dẫn đánh giá xe",
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
                    "1. Chọn 'Đánh giá'.",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Image.asset(
                      'lib/assets/images/help/rating_screen/rating.png'),
                  SizedBox(height: 8),
                  Text(
                    "2. Điền đánh giá.",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Image.asset('lib/assets/images/help/rating_screen/fill.png'),
                  SizedBox(height: 8),
                  Text(
                    "3. Hiển thị thông báo.",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Image.asset(
                      'lib/assets/images/help/rating_screen/success.png'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
