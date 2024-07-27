import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/screens/auth/email_verification_screen.dart';
import 'package:vehicle_rental_app/screens/auth/login_screen.dart';
import 'package:vehicle_rental_app/screens/loading_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';
import 'package:vehicle_rental_app/utils/utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final userController = Get.put(UserController());

  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
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
                          "ĐĂNG KÝ",
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
                                  controller: name,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.person_outline_outlined),
                                    labelText: 'Họ và tên',
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
                              const SizedBox(height: 15),
                              Container(
                                height: 50,
                                child: TextField(
                                  controller: email,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.email_outlined),
                                    labelText: 'Email',
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
                              const SizedBox(height: 15),
                              Container(
                                height: 50,
                                child: TextField(
                                  controller: phone,
                                  style: const TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.phone_outlined),
                                    labelText: 'Số điện thoại',
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
                              SizedBox(height: 15),
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
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                        color: Constants.primaryColor,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.all(12),
                                  ),
                                  obscureText: obscureText,
                                ),
                              ),
                              const SizedBox(height: 25),
                              SizedBox(
                                width: double.infinity,
                                height: 46,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (name.text.trim().isEmpty ||
                                        email.text.trim().isEmpty ||
                                        phone.text.trim().isEmpty ||
                                        password.text.trim().isEmpty) {
                                      Utils.showSnackBar(
                                        "Vui lòng điền đầy đủ thông tin!",
                                        Colors.red,
                                        Icons.error,
                                      );
                                    } else if (!Utils.isPhoneNumber(
                                        phone.text.trim())) {
                                      Utils.showSnackBar(
                                        "Số điện thoại không hợp lệ!",
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
                                      final user = UserModel(
                                        name: name.text.trim(),
                                        email: email.text.trim(),
                                        phone: phone.text.trim(),
                                        password: password.text.trim(),
                                        isAdmin: false,
                                        provider: "password",
                                      );

                                      setState(() {
                                        isLoading = true;
                                      });

                                      String? result =
                                          await userController.createUser(user);
                                      if (result != null) {
                                        Utils.showSnackBar(
                                          result,
                                          Colors.red,
                                          Icons.error,
                                        );
                                      } else {
                                        Get.to(() =>
                                            const EmailVerificationScreen());
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
                                    "ĐĂNG KÝ",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
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
                                ? const CircularProgressIndicator(
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
                            Get.to(() => const LoginScreen());
                          },
                          child: const Text.rich(
                            TextSpan(
                              text: "Bạn đã có tài khoản? ",
                              style: TextStyle(
                                  color: Color(0xff888888),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                  text: "Đăng nhập",
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
