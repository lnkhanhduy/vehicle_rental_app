import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/screens/auth/login_screen.dart';
import 'package:vehicle_rental_app/screens/loading_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';
import 'package:vehicle_rental_app/utils/utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final userController = Get.put(UserController());

  final email = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: isLoading
                ? LoadingScreen()
                : Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "QUÊN MẬT KHẨU",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Vui lòng nhập email của bạn để đặt lại mật khẩu.",
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        Container(
                          height: 50,
                          child: TextField(
                            controller: email,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.mail_outline_outlined),
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                              ),
                              labelStyle: TextStyle(
                                color: Color(0xff888888),
                                fontSize: 15,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Constants.primaryColor,
                                ),
                              ),
                              contentPadding: EdgeInsets.all(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: double.infinity,
                          height: 44,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (email.text.trim().isEmpty) {
                                Utils.showSnackBar(
                                  "Vui lòng điền email!",
                                  Colors.red,
                                  Icons.error,
                                );
                              } else if (!Utils.isValidEmail(
                                  email.text.trim())) {
                                Utils.showSnackBar(
                                  "Email không hợp lệ!",
                                  Colors.red,
                                  Icons.error,
                                );
                              } else {
                                setState(() {
                                  isLoading = true;
                                });
                                await userController
                                    .forgotPassword(email.text.trim());
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black87,
                              foregroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                            ),
                            child: const Text(
                              "Gửi",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextButton(
                          onPressed: () {
                            Get.to(() => const LoginScreen());
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_back, color: Colors.black87),
                              SizedBox(width: 10),
                              Text(
                                "Đăng nhập",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black87),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
