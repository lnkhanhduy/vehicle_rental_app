import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/screens/loading_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final userController = Get.put(UserController());

  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  bool obscureText = true;
  bool isLoading = false;

  void togglePasswordStatus() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_outlined)),
        title: const Text(
          "Đổi mật khẩu",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: isLoading
              ? LoadingScreen()
              : Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 5),
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
                          const SizedBox(height: 20),
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
                          const SizedBox(height: 25),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (password.text.trim().isNotEmpty &&
                                    confirmPassword.text.trim().isNotEmpty &&
                                    password.text.trim() ==
                                        confirmPassword.text.trim()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  String? result =
                                      await userController.changePassword(
                                          password.text.trim(),
                                          confirmPassword.text.trim());

                                  if (result != null) {
                                    Get.closeCurrentSnackbar();
                                    Get.showSnackbar(GetSnackBar(
                                      messageText: Text(
                                        result,
                                        style: const TextStyle(
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
                                  setState(() {
                                    isLoading = false;
                                  });
                                } else if (password.text.trim() !=
                                    confirmPassword.text.trim()) {
                                  Get.closeCurrentSnackbar();
                                  Get.showSnackbar(GetSnackBar(
                                    messageText: const Text(
                                      "Mật khẩu không trùng khớp!",
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
                                } else if (password.text.trim().isNotEmpty &&
                                    confirmPassword.text.trim().isNotEmpty &&
                                    (password.text.trim().length < 6 ||
                                        confirmPassword.text.trim().length <
                                            6)) {
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
                                } else {
                                  Get.closeCurrentSnackbar();
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
                        ]),
                      ),
                    )
                  ]),
                ),
        )
      ]),
    );
  }
}
