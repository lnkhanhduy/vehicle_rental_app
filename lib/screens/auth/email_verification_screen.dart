import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/email_verification_controller.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/screens/loading_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final userController = Get.put(UserController());
  final emailController = Get.put(EmailVerificationController());

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: isLoading
              ? LoadingScreen()
              : Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
                          "Chúng tôi đã gửi email xác minh cho bạn. Vui lòng kiểm tra email và ấn vào liên kết để xác minh email!",
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Ấn vào nút "Tiếp tục". Nếu bạn đã xác minh email.',
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 30),
                        SizedBox(
                            width: 180,
                            height: 50,
                            child: OutlinedButton(
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                await emailController
                                    .manuallyCheckEmailVerificationStatus();
                                setState(() {
                                  isLoading = false;
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.black,
                                side: BorderSide(color: Colors.black),
                              ),
                              child: Text("Tiếp tục",
                                  style: TextStyle(fontSize: 16)),
                            )),
                        SizedBox(height: 30),
                        TextButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            bool result =
                                await emailController.sendVerificationEmail();
                            print(result);
                            if (result) {
                              Get.closeCurrentSnackbar();
                              Get.showSnackbar(GetSnackBar(
                                messageText: Text(
                                  "Chúng tôi đã gửi lại email xác minh cho bạn!",
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                backgroundColor: Colors.green,
                                duration: const Duration(seconds: 3),
                                icon: const Icon(Icons.check,
                                    color: Colors.white),
                                onTap: (_) {
                                  Get.closeCurrentSnackbar();
                                },
                              ));
                            } else {
                              Get.closeCurrentSnackbar();
                              Get.showSnackbar(GetSnackBar(
                                messageText: Text(
                                  "Có lỗi xảy ra vui lòng thử lại sau!",
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                backgroundColor: Colors.red,
                                duration: const Duration(seconds: 3),
                                icon: const Icon(Icons.error_outline_outlined,
                                    color: Colors.white),
                                onTap: (_) {
                                  Get.closeCurrentSnackbar();
                                },
                              ));
                            }
                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: Text(
                            "Gửi lại email xác minh",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            userController.logout();
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Transform.rotate(
                                  angle: 3.14,
                                  child: Icon(
                                    Icons.arrow_right_alt_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Đăng nhập",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                )
                              ]),
                        ),
                      ]),
                ),
        )
      ]),
    );
  }
}
