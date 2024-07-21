import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/screens/auth/forgot_password_screen.dart';
import 'package:vehicle_rental_app/screens/auth/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;
  final username = TextEditingController();
  final password = TextEditingController();
  bool isWaitingGoogle = false;
  bool isWaiting = false;

  void togglePasswordStatus() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.closeCurrentSnackbar();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            color: Colors.white,
            child: isWaiting
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        const Text(
                          "ĐĂNG NHẬP",
                          style: TextStyle(
                            fontSize: 28,
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
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.person_outline_outlined),
                                    labelText: 'Email/Số điện thoại',
                                    border: OutlineInputBorder(),
                                    labelStyle:
                                        TextStyle(color: Color(0xff888888)),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: password,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    labelText: 'Mật khẩu',
                                    border: const OutlineInputBorder(),
                                    labelStyle: const TextStyle(
                                        color: Color(0xff888888)),
                                    prefixIcon: const Icon(Icons.fingerprint),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        obscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: togglePasswordStatus,
                                    ),
                                  ),
                                  obscureText: obscureText,
                                ),
                                const SizedBox(height: 12),
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
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                                const SizedBox(height: 3),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (password.text.trim().isEmpty ||
                                          username.text.trim().isEmpty) {
                                        Get.closeCurrentSnackbar();
                                        Get.showSnackbar(GetSnackBar(
                                          messageText: const Text(
                                            "Vui lòng điền đầy đủ thông tin!",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          backgroundColor: Colors.red,
                                          duration: const Duration(seconds: 3),
                                          icon: const Icon(Icons.error,
                                              color: Colors.white),
                                          onTap: (_) {
                                            Get.closeCurrentSnackbar();
                                          },
                                        ));
                                      } else if (password.text.trim().length <
                                          6) {
                                        Get.closeCurrentSnackbar();
                                        Get.showSnackbar(GetSnackBar(
                                          messageText: const Text(
                                            "Mật khẩu ít nhất 6 ký tự!",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          backgroundColor: Colors.red,
                                          duration: const Duration(seconds: 3),
                                          icon: const Icon(Icons.error,
                                              color: Colors.white),
                                          onTap: (_) {
                                            Get.closeCurrentSnackbar();
                                          },
                                        ));
                                      } else if (username.text
                                              .trim()
                                              .isNotEmpty &&
                                          password.text.trim().isNotEmpty) {
                                        setState(() {
                                          isWaiting = true;
                                        });
                                        await UserController.instance.login(
                                            username.text.trim(),
                                            password.text.trim());
                                        setState(() {
                                          isWaiting = false;
                                        });
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black87,
                                      foregroundColor: Colors.white,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
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
                                  fontSize: 16,
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              icon: isWaitingGoogle
                                  ? const CircularProgressIndicator(
                                      color: Colors.black87, strokeWidth: 1.5)
                                  : Image.asset(
                                      "lib/assets/images/logo_google.png",
                                      width: 30,
                                    ),
                              onPressed: () async {
                                setState(() {
                                  isWaitingGoogle = true;
                                });
                                await UserController.instance
                                    .signInWithGoogle();
                                setState(() {
                                  isWaitingGoogle = false;
                                });
                              },
                              label: const Text(
                                "Đăng nhập với Google",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.black87),
                              )),
                          //
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(() => const RegisterScreen());
                          },
                          child: const Text.rich(TextSpan(
                              text: "Bạn chưa có tài khoản? ",
                              style: TextStyle(
                                  color: Color(0xff888888),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                  text: "Đăng ký",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 15,
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
