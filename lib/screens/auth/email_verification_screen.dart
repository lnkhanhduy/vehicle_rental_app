import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/email_verification_controller.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final controller = Get.put(EmailVerificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            color: Colors.white,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.mark_email_unread_outlined, size: 120),
                  const SizedBox(height: 15),
                  Text(
                    "Xác minh email của bạn",
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Chúng tôi đã gửi liên kết xác minh email cho bạn. Vui lòng kiểm tra email và ấn vào liên kết để xác minh email!",
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 25),
                  Text(
                    'Ấn vào nút "Tiếp tục!". Nếu bạn đã xác minh email.',
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 45),
                  SizedBox(
                      width: 200,
                      height: 56,
                      child: OutlinedButton(
                        onPressed: () {
                          controller.manuallyCheckEmailVerificationStatus();
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black,
                          side: BorderSide(color: Colors.black),
                        ),
                        child: Text("Tiếp tục", style: TextStyle(fontSize: 17)),
                      )),
                  SizedBox(height: 45),
                  TextButton(
                      onPressed: () {
                        controller.sendVerificationEmail();
                      },
                      child: Text("Gửi lại mã xác minh",
                          style: TextStyle(fontSize: 17, color: Colors.black))),
                  TextButton(
                    onPressed: () {
                      UserController.instance..logout();
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_back),
                          const SizedBox(width: 5),
                          Text("Đăng nhập",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.black))
                        ]),
                  ),
                ]),
          ),
        )
      ]),
    );
  }
}
