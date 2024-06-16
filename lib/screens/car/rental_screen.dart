import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RentalScreen extends StatefulWidget {
  const RentalScreen({super.key});

  @override
  State<RentalScreen> createState() => _RentalScreenState();
}

class _RentalScreenState extends State<RentalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
        title: const Text(
          "Đăng ký xe",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 40, 10, 20),
              constraints: const BoxConstraints.expand(),
              color: Colors.white,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("Rental"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
