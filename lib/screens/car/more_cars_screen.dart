import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoreCarsScreen extends StatefulWidget {
  final String titleScreen;

  const MoreCarsScreen({super.key, required this.titleScreen});

  @override
  State<MoreCarsScreen> createState() => _MoreCarsScreenState();
}

class _MoreCarsScreenState extends State<MoreCarsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
        title: Text(
          widget.titleScreen,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
