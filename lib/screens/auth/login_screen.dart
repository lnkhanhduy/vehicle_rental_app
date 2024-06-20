import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/login_controller.dart';
import 'package:vehicle_rental_app/screens/auth/forgot_password_screen.dart';
import 'package:vehicle_rental_app/screens/auth/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;

  void _togglePasswordStatus() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final username = TextEditingController();
    final password = TextEditingController();

    Get.closeCurrentSnackbar();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            padding: const EdgeInsets.fromLTRB(30, 40, 30, 20),
            color: Colors.white,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "ĐĂNG NHẬP",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: username,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.person_outline_outlined),
                                labelText: 'Email/Số điện thoại',
                                border: OutlineInputBorder(),
                                labelStyle: TextStyle(
                                    color: Color(0xff888888), fontSize: 16)),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: password,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Mật khẩu',
                              border: const OutlineInputBorder(),
                              labelStyle: const TextStyle(
                                  color: Color(0xff888888), fontSize: 16),
                              prefixIcon: const Icon(Icons.fingerprint),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: _togglePasswordStatus,
                              ),
                            ),
                            obscureText: _obscureText,
                          ),
                          const SizedBox(height: 15),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {
                                  Get.to(const ForgotPasswordScreen());
                                },
                                child: const Text(
                                  "Quên mật khẩu?",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          const SizedBox(height: 3),
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () {
                                if (username.text.trim().isNotEmpty &&
                                    password.text.trim().isNotEmpty) {
                                  controller.loginUser(username.text.trim(),
                                      password.text.trim());
                                } else {
                                  Get.closeCurrentSnackbar();
                                  Get.showSnackbar(GetSnackBar(
                                    messageText: Text(
                                      "Vui lòng điền đầy đủ thông tin!",
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: Colors.red,
                                    duration: const Duration(seconds: 10),
                                    icon: const Icon(Icons.error,
                                        color: Colors.white),
                                    onTap: (_) {
                                      Get.closeCurrentSnackbar();
                                    },
                                  ));
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
                                "ĐĂNG NHẬP",
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Hoặc",
                          style: TextStyle(
                            fontSize: 17,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        icon: Image.asset(
                          "lib/assets/images/logo_google.png",
                          width: 30,
                        ),
                        onPressed: () {
                          LoginController.instance.googleSignIn();
                        },
                        label: const Text(
                          "Đăng nhập với Google",
                          style: TextStyle(fontSize: 17, color: Colors.black87),
                        )),
                    //
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => const RegisterScreen());
                    },
                    child: const Text.rich(TextSpan(
                        text: "Bạn chưa có tài khoản? ",
                        style: TextStyle(
                            color: Color(0xff888888),
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text: "Đăng ký",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )
                        ])),
                  )
                ]),
          ),
        )
      ]),
    );
  }
}
