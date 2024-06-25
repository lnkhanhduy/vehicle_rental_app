import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/screens/layout_screen.dart';

class HistoryRentalScreen extends StatefulWidget {
  const HistoryRentalScreen({super.key});

  @override
  State<HistoryRentalScreen> createState() => _HistoryRentalScreenState();
}

class _HistoryRentalScreenState extends State<HistoryRentalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.to(() => const LayoutScreen(initialIndex: 3)),
            icon: const Icon(Icons.arrow_back)),
        title: const Text(
          "Lịch sử cho thuê xe",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  Text("History rental screen"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
