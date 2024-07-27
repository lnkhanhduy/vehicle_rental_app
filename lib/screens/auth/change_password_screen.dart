import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/screens/loading_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';
import 'package:vehicle_rental_app/utils/utils.dart';

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
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: isLoading
                ? LoadingScreen()
                : Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 20),
                    constraints: const BoxConstraints.expand(),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          child: TextField(
                            controller: password,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Mật khẩu mới',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.1),
                                  )),
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
                        const SizedBox(height: 10),
                        Container(
                          height: 50,
                          child: TextField(
                            controller: confirmPassword,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Nhập lại mật khẩu mới',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                              ),
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
                        const SizedBox(height: 18),
                        SizedBox(
                          width: double.infinity,
                          height: 44,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (password.text.trim().isNotEmpty &&
                                  confirmPassword.text.trim().isNotEmpty) {
                                if (password.text.trim() !=
                                    confirmPassword.text.trim()) {
                                  Utils.showSnackBar(
                                    "Mật khẩu không trùng khớp!",
                                    Colors.red,
                                    Icons.error,
                                  );
                                } else if (password.text.trim().length < 6 ||
                                    confirmPassword.text.trim().length < 6) {
                                  Utils.showSnackBar(
                                    "Mật khẩu ít nhất 6 ký tự!",
                                    Colors.red,
                                    Icons.error,
                                  );
                                } else {
                                  // Change password
                                  setState(() {
                                    isLoading = true;
                                  });

                                  String? result =
                                      await userController.changePassword(
                                    password.text.trim(),
                                    confirmPassword.text.trim(),
                                  );

                                  if (result != null) {
                                    Utils.showSnackBar(
                                      result,
                                      Colors.red,
                                      Icons.error,
                                    );
                                  } else {
                                    Utils.showSnackBar(
                                      "Mật khẩu đã được thay đổi thành công!",
                                      Colors.green,
                                      Icons.check,
                                    );
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              } else {
                                Utils.showSnackBar(
                                  "Vui lòng điền đầy đủ thông tin!",
                                  Colors.red,
                                  Icons.error,
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
                              "CẬP NHẬT",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
