import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/screens/auth/login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              color: Colors.white,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "QUÊN MẬT KHẨU",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Vui lòng nhập email của bạn để đặt lại mật khẩu.",
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                        child: Column(
                      children: [
                        TextFormField(
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.mail_outline_outlined),
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                              labelStyle: TextStyle(
                                  color: Color(0xff888888), fontSize: 16)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: () {
                              // Get.to(() => const OtpScreen());
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
                              "TIẾP TỤC",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                    const SizedBox(
                      height: 50,
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(() => const LoginScreen());
                        },
                        child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_back),
                              SizedBox(width: 5),
                              Text("Đăng nhập",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black))
                            ]))
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
