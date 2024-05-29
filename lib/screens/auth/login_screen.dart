import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/login_controller.dart';
import 'package:vehicle_rental_app/screens/auth/register_screen.dart';
import 'package:vehicle_rental_app/screens/forgot_password/forgot_password_mail_screen.dart';
import 'package:vehicle_rental_app/screens/forgot_password/forgot_password_phone_screen.dart';

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
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
            color: Colors.white,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
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
                  Form(
                    key: formKey,
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: controller.email,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                              decoration: const InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.person_outline_outlined),
                                  labelText: 'Email/Số điện thoại',
                                  border: OutlineInputBorder(),
                                  labelStyle: TextStyle(
                                      color: Color(0xff888888), fontSize: 16)),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: controller.password,
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
                                  onPressed: forgotPasswordPressed,
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
                                  if (formKey.currentState!.validate()) {
                                    LoginController.instance.loginUser(
                                      controller.email.text.trim(),
                                      controller.password.text.trim(),
                                    );
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
                  ),
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
                        onPressed: signInGooglePressed,
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
                      Navigator.pop(context);
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

  void signInPressed() {
    print("Clicked");
  }

  void signInGooglePressed() {
    print("Clicked");
  }

  void forgotPasswordPressed() {
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                    child: Text("QUÊN MẬT KHẨU",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold))),
                const SizedBox(
                  height: 5,
                ),
                const Align(
                    child: Text("Chọn phương thức để lấy lại mật khẩu",
                        style: TextStyle(fontSize: 17))),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                    onTap: forgotPasswordEmailPressed,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade200),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.mail_outline_rounded,
                            size: 60,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("E-Mail",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Text("Đặt lại mật khẩu bằng E-Mail",
                                  style: TextStyle(fontSize: 16)),
                            ],
                          )
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: forgotPasswordPhonePressed,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade200),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.mobile_friendly_rounded,
                            size: 60,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Số điện thoại",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Text("Đặt lại mật khẩu bằng số điện thoại",
                                  style: TextStyle(fontSize: 16)),
                            ],
                          )
                        ],
                      ),
                    ))
              ],
            )));
  }

  void forgotPasswordEmailPressed() {
    Navigator.pop(context);
    Get.to(() => const ForgotPasswordMailScreen());
  }

  void forgotPasswordPhonePressed() {
    Navigator.pop(context);
    Get.to(() => const ForgotPasswordPhoneScreen());
  }
}