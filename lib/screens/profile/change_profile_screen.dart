import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/screens/loading_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';
import 'package:vehicle_rental_app/utils/utils.dart';

class ChangeProfileScreen extends StatefulWidget {
  const ChangeProfileScreen({super.key});

  @override
  State<ChangeProfileScreen> createState() => _ChangeProfileScreenState();
}

class _ChangeProfileScreenState extends State<ChangeProfileScreen> {
  final userController = Get.put(UserController());

  Uint8List? imageAvatarEdit;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_outlined)),
        title: const Text(
          "Tài khoản của tôi",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: isLoading == true
                ? LoadingScreen()
                : Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    constraints: const BoxConstraints.expand(),
                    color: Colors.white,
                    child: FutureBuilder(
                      future: userController.getUserData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return LoadingScreen();
                        }
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          UserModel userData = snapshot.data as UserModel;
                          final name =
                              TextEditingController(text: userData.name);
                          final email =
                              TextEditingController(text: userData.email);
                          final phone =
                              TextEditingController(text: userData.phone);
                          final imageUrl = userData.imageAvatar;
                          final password =
                              TextEditingController(text: userData.password);
                          final address =
                              TextEditingController(text: userData.address);
                          final selectedInfo =
                              userData.isPublic ? 'public' : 'private';

                          return Column(children: [
                            GestureDetector(
                              onTap: () async {
                                Uint8List? imgAvatar =
                                    await Utils.pickImage(ImageSource.gallery);
                                if (imgAvatar != null) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  if (imageUrl != null) {
                                    await Utils.deleteImageIfExists(imageUrl);
                                  }
                                  await Utils.uploadImage(imgAvatar, 'users',
                                      email.text, 'imageAvatar', "Users");
                                  Get.closeCurrentSnackbar();
                                  Get.showSnackbar(GetSnackBar(
                                    messageText: const Text(
                                      "Đổi ảnh đại diện thành công!",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: Colors.green,
                                    duration: const Duration(seconds: 3),
                                    icon: const Icon(Icons.check_circle,
                                        color: Colors.white),
                                    onTap: (_) {
                                      Get.closeCurrentSnackbar();
                                    },
                                  ));
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              },
                              child: Stack(
                                children: [
                                  SizedBox(
                                    width: 120,
                                    height: 120,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(100)),
                                      child: imageAvatarEdit != null
                                          ? Image(
                                              image: MemoryImage(
                                                imageAvatarEdit!,
                                              ),
                                            )
                                          : imageUrl != null
                                              ? Image.network(
                                                  imageUrl,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Image.asset(
                                                      "lib/assets/images/no_avatar.png",
                                                      fit: BoxFit.cover,
                                                    );
                                                  },
                                                )
                                              : Image.asset(
                                                  "lib/assets/images/no_avatar.png",
                                                  fit: BoxFit.cover,
                                                ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Constants.primaryColor,
                                      ),
                                      child: const Icon(Icons.camera_alt,
                                          size: 20, color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  TextFormField(
                                    readOnly: true,
                                    controller: email,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.email_outlined),
                                      labelText: 'Email',
                                      border: OutlineInputBorder(),
                                      labelStyle: TextStyle(
                                        color: Color(0xff888888),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: name,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      prefixIcon:
                                          Icon(Icons.person_outline_outlined),
                                      labelText: 'Họ và tên',
                                      border: OutlineInputBorder(),
                                      labelStyle:
                                          TextStyle(color: Color(0xff888888)),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: phone,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.phone_outlined),
                                        labelText: 'Số điện thoại',
                                        border: OutlineInputBorder(),
                                        labelStyle: TextStyle(
                                          color: Color(0xff888888),
                                        )),
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: address,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.location_on),
                                        labelText: 'Địa chỉ',
                                        border: OutlineInputBorder(),
                                        labelStyle: TextStyle(
                                          color: Color(0xff888888),
                                        )),
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    "Hiển thị thông tin",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    child: FormField<String>(
                                      builder: (FormFieldState<String> state) {
                                        return InputDecorator(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.1),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              borderSide: BorderSide(
                                                color: Constants.primaryColor,
                                              ),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 12),
                                          ),
                                          isEmpty: selectedInfo == '',
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              value: selectedInfo,
                                              isDense: true,
                                              onChanged: (newValue) async {
                                                await userController
                                                    .changeStatus(newValue!);
                                                Get.closeCurrentSnackbar();
                                                Get.showSnackbar(GetSnackBar(
                                                  messageText: const Text(
                                                    "Cập nhật hiển thị thông tin thành công!",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  backgroundColor: Colors.green,
                                                  duration: const Duration(
                                                      seconds: 3),
                                                  icon: const Icon(Icons.check,
                                                      color: Colors.white),
                                                  onTap: (_) {
                                                    Get.closeCurrentSnackbar();
                                                  },
                                                ));
                                                setState(() {});
                                              },
                                              items: ['public', 'private']
                                                  .map((String info) {
                                                return DropdownMenuItem<String>(
                                                  value: info,
                                                  child: Text(info == 'private'
                                                      ? 'Ẩn'
                                                      : 'Hiển thị'),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 25),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 48,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (email.text.trim().isEmpty ||
                                            name.text.trim().isEmpty ||
                                            phone.text.trim().isEmpty ||
                                            address.text.trim().isEmpty) {
                                          Get.closeCurrentSnackbar();
                                          Get.showSnackbar(GetSnackBar(
                                            messageText: const Text(
                                              "Vui lòng điền đầy đủ thông tin!",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            backgroundColor: Colors.red,
                                            duration:
                                                const Duration(seconds: 3),
                                            icon: const Icon(Icons.error,
                                                color: Colors.white),
                                            onTap: (_) {
                                              Get.closeCurrentSnackbar();
                                            },
                                          ));
                                        } else {
                                          final user = UserModel(
                                            email: email.text.trim(),
                                            name: name.text.trim(),
                                            phone: phone.text.trim(),
                                            password: password.text.trim(),
                                            address: address.text.trim(),
                                            provider: userData.provider,
                                            imageAvatar: userData.imageAvatar,
                                            imageLicenseFront:
                                                userData.imageLicenseFront,
                                            imageLicenseBack:
                                                userData.imageLicenseBack,
                                            imageIdCardFront:
                                                userData.imageIdCardFront,
                                            imageIdCardBack:
                                                userData.imageIdCardBack,
                                            isVerified: userData.isVerified,
                                            message: userData.message,
                                            isAdmin: userData.isAdmin,
                                            isPublic: userData.isPublic,
                                          );

                                          setState(() {
                                            isLoading = true;
                                          });
                                          await userController.updateUser(user);
                                          setState(() {
                                            isLoading = false;
                                          });
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black87,
                                        foregroundColor: Colors.white,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
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
                                ],
                              ),
                            ),
                          ]);
                        }
                        return Container();
                      },
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
