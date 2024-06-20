import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/login_controller.dart';
import 'package:vehicle_rental_app/controllers/register_controller.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/screens/auth/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscureText = true;

  void _togglePasswordStatus() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    final name = TextEditingController();
    final email = TextEditingController();
    final phone = TextEditingController();
    final password = TextEditingController();

    Get.closeCurrentSnackbar();
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: const EdgeInsets.fromLTRB(30, 40, 30, 20),
              color: Colors.white,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "ĐĂNG KÝ",
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
                              controller: name,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                              decoration: const InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.person_outline_outlined),
                                  labelText: 'Họ và tên',
                                  border: OutlineInputBorder(),
                                  labelStyle: TextStyle(
                                      color: Color(0xff888888), fontSize: 16)),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: email,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.email_outlined),
                                  labelText: 'Email',
                                  border: OutlineInputBorder(),
                                  labelStyle: TextStyle(
                                      color: Color(0xff888888), fontSize: 16)),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: phone,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.phone_outlined),
                                  labelText: 'Số điện thoại',
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
                            const SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (name.text.trim().isNotEmpty &&
                                      email.text.trim().isNotEmpty &&
                                      phone.text.trim().isNotEmpty &&
                                      password.text.trim().isNotEmpty) {
                                    final user = UserModel(
                                      name: name.text.trim(),
                                      email: email.text.trim(),
                                      phone: phone.text.trim(),
                                      password: password.text.trim(),
                                      isAdmin: false,
                                      provider: "password",
                                    );

                                    controller.createUser(user);
                                  } else {
                                    Get.showSnackbar(GetSnackBar(
                                      messageText: const Text(
                                        "Vui lòng điền đầy đủ thông tin",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      backgroundColor: Colors.red,
                                      duration: const Duration(seconds: 10),
                                      icon: const Icon(Icons.error,
                                          color: Colors.white),
                                      onTap: (_) {},
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
                                  "ĐĂNG KÝ",
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
                            style:
                                TextStyle(fontSize: 17, color: Colors.black87),
                          )),
                      //
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => const LoginScreen());
                      },
                      child: const Text.rich(TextSpan(
                          text: "Bạn đã có tài khoản? ",
                          style: TextStyle(
                              color: Color(0xff888888),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: "Đăng nhập",
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
        ],
      ),
    );
  }
}
