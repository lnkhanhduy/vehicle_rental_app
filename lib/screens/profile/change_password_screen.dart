import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/profile_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool _obscureText = true;

  void _togglePasswordStatus() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    Get.closeCurrentSnackbar();
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
          title: const Text(
            "Đổi mật khẩu",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
                  constraints: const BoxConstraints.expand(),
                  color: Colors.white,
                  child: Column(children: [
                    Form(
                        child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(children: <Widget>[
                              TextFormField(
                                controller: controller.password,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.black),
                                decoration: InputDecoration(
                                  labelText: 'Mật khẩu mới',
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
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: controller.confirmPassword,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.black),
                                decoration: InputDecoration(
                                  labelText: 'Nhập lại mật khẩu mới',
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
                              const SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final password =
                                        controller.password.text.trim();
                                    final confirmPassword =
                                        controller.password.text.trim();
                                    await controller.changePassword(
                                        password, confirmPassword);
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
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ])))
                  ])))
        ]));
  }
}
