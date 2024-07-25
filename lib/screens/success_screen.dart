import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/screens/layout_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';

class SuccessScreen extends StatefulWidget {
  final String title;
  final String content;

  const SuccessScreen({super.key, required this.title, required this.content});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
              constraints: const BoxConstraints.expand(),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.check_circle,
                    color: Constants.primaryColor,
                    size: 65,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.content,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  TextButton(
                    onPressed: () {
                      Get.to(() => const LayoutScreen(
                            initialIndex: 0,
                          ));
                    },
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                          SizedBox(width: 5),
                          Text("Trở về trang chủ",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black))
                        ]),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
