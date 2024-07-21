import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool obscureText = true;

  void togglePasswordStatus() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final password = TextEditingController();
    final confirmPassword = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back_ios_outlined)),
          title: const Text(
            "Đổi mật khẩu",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  constraints: const BoxConstraints.expand(),
                  color: Colors.white,
                  child: Column(children: [
                    Form(
                        child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(children: <Widget>[
                              TextFormField(
                                controller: password,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  labelText: 'Mật khẩu mới',
                                  border: const OutlineInputBorder(),
                                  labelStyle:
                                      const TextStyle(color: Color(0xff888888)),
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
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: confirmPassword,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  labelText: 'Nhập lại mật khẩu mới',
                                  border: const OutlineInputBorder(),
                                  labelStyle:
                                      const TextStyle(color: Color(0xff888888)),
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
                              const SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (password.text.trim().isNotEmpty &&
                                        confirmPassword.text
                                            .trim()
                                            .isNotEmpty &&
                                        password.text.trim() ==
                                            confirmPassword.text.trim()) {
                                      await UserController.instance
                                          .changePassword(password.text.trim(),
                                              confirmPassword.text.trim());
                                    } else {
                                      Get.showSnackbar(GetSnackBar(
                                        messageText: const Text(
                                          "Vui lòng điền đầy đủ thông tin!",
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
                                    "CẬP NHẬT",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ])))
                  ])))
        ]));
  }
}
