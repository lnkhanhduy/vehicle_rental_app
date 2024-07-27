import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/screens/layout_screen.dart';
import 'package:vehicle_rental_app/screens/loading_screen.dart';
import 'package:vehicle_rental_app/utils/utils.dart';

class OtpScreen extends StatefulWidget {
  final String phone;

  const OtpScreen({super.key, required this.phone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final userController = Get.put(UserController());
  late String? verificationId = "";

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initSendOTP();
  }

  Future<bool> initSendOTP() async {
    String? result = await userController.sendOTP(widget.phone);
    if (result != null) {
      verificationId = result;
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      children: <Widget>[
                        const Text(
                          "NHẬP MÃ XÁC MINH",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Nhập mã xác minh đã được gửi tới số điện thoại \n${widget.phone}",
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 25),
                        OtpTextField(
                          mainAxisAlignment: MainAxisAlignment.center,
                          numberOfFields: 6,
                          fillColor: Colors.black.withOpacity(0.1),
                          filled: true,
                          borderColor: Color(0xFF512DA8),
                          showFieldAsBox: true,
                          onSubmit: (code) async {
                            setState(() {
                              isLoading = true;
                            });

                            bool result = await userController.checkOTP(
                                verificationId!, code);
                            if (result) {
                              bool isUpdated = await userController
                                  .updatePhone(widget.phone);
                              if (isUpdated) {
                                Get.to(
                                    () => const LayoutScreen(initialIndex: 4));

                                Utils.showSnackBar(
                                  "Cập nhật thông tin thành công!",
                                  Colors.green,
                                  Icons.check,
                                );
                              }
                            } else {
                              Utils.showSnackBar(
                                "Sai mã OTP.",
                                Colors.red,
                                Icons.error,
                              );
                            }
                            setState(() {
                              isLoading = false;
                            });
                          },
                        ),
                        const SizedBox(height: 30),
                        TextButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            bool result = await initSendOTP();
                            if (result) {
                              Utils.showSnackBar(
                                "Chúng tôi đã gửi lại mã xác minh cho bạn.!",
                                Colors.green,
                                Icons.check,
                              );
                            }
                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: Text(
                            "Gửi lại OTP",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(LayoutScreen(initialIndex: 4));
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Transform.rotate(
                                angle: 3.14,
                                child: Icon(
                                  Icons.arrow_right_alt_outlined,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Trở về",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              )
                            ],
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
