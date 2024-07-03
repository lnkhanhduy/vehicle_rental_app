import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/screens/auth/login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    Get.closeCurrentSnackbar();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              color: Colors.white,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "QUÊN MẬT KHẨU",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Vui lòng nhập email của bạn để đặt lại mật khẩu.",
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),
                    TextField(
                      controller: email,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.mail_outline_outlined),
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(color: Color(0xff888888))),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (email.text.trim().isEmpty) {
                            Get.showSnackbar(GetSnackBar(
                              messageText: const Text(
                                "Vui lòng điền email!",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: Colors.red,
                              duration: const Duration(seconds: 3),
                              icon:
                                  const Icon(Icons.error, color: Colors.white),
                              onTap: (_) {
                                Get.closeCurrentSnackbar();
                              },
                            ));
                          } else {
                            await controller.forgotPassword(email.text.trim());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87,
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                        ),
                        child: const Text(
                          "TIẾP TỤC",
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(() => const LoginScreen());
                        },
                        child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_back,
                                color: Colors.black87,
                              ),
                              SizedBox(width: 10),
                              Text("Đăng nhập",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black87))
                            ]))
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
