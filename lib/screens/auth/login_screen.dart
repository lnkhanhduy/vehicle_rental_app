import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/screens/auth/forgot_password_screen.dart';
import 'package:vehicle_rental_app/screens/auth/register_screen.dart';
import 'package:vehicle_rental_app/screens/loading_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';
import 'package:vehicle_rental_app/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userController = Get.put(UserController());

  final username = TextEditingController();
  final password = TextEditingController();

  bool obscureText = true;
  bool isLoadingGoogle = false;
  bool isLoading = false;

  void togglePasswordStatus() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
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
                      children: [
                        const Text(
                          "ĐĂNG NHẬP",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                child: TextField(
                                  controller: username,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.person_outline_outlined),
                                    labelText: 'Email/Số điện thoại',
                                    border: OutlineInputBorder(),
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
                              const SizedBox(height: 18),
                              Container(
                                height: 50,
                                child: TextField(
                                  controller: password,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    labelText: 'Mật khẩu',
                                    border: const OutlineInputBorder(),
                                    labelStyle: const TextStyle(
                                      color: Color(0xff888888),
                                      fontSize: 15,
                                    ),
                                    prefixIcon: const Icon(Icons.fingerprint),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        obscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        size: 20,
                                      ),
                                      onPressed: togglePasswordStatus,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: Constants.primaryColor,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.all(12),
                                  ),
                                  obscureText: obscureText,
                                ),
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
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 3),
                              SizedBox(
                                width: double.infinity,
                                height: 46,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (password.text.trim().isEmpty ||
                                        username.text.trim().isEmpty) {
                                      Utils.showSnackBar(
                                        "Vui lòng điền đầy đủ thông tin!",
                                        Colors.red,
                                        Icons.error,
                                      );
                                    } else if (password.text.trim().length <
                                        6) {
                                      Utils.showSnackBar(
                                        "Mật khẩu ít nhất 6 ký tự!",
                                        Colors.red,
                                        Icons.error,
                                      );
                                    } else {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      bool result = await userController.login(
                                        username.text.trim(),
                                        password.text.trim(),
                                      );

                                      if (!result) {
                                        Utils.showSnackBar(
                                          "Tài khoản hoặc mật khẩu không chính xác!",
                                          Colors.red,
                                          Icons.error,
                                        );
                                      }
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
                                    "ĐĂNG NHẬP",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Hoặc", style: TextStyle(fontSize: 15))
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 46,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            icon: isLoadingGoogle
                                ? CircularProgressIndicator(
                                    color: Colors.black87,
                                    strokeWidth: 2,
                                  )
                                : Image.asset(
                                    "lib/assets/images/logo_google.png",
                                    width: 30,
                                  ),
                            onPressed: () async {
                              setState(() {
                                isLoadingGoogle = true;
                              });
                              await userController.signInWithGoogle();
                              setState(() {
                                isLoadingGoogle = false;
                              });
                            },
                            label: const Text(
                              "Đăng nhập với Google",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextButton(
                          onPressed: () {
                            Get.to(() => const RegisterScreen());
                          },
                          child: const Text.rich(
                            TextSpan(
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
                              ],
                            ),
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
