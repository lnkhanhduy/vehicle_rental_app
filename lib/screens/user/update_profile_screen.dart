import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/screens/user/profile_screen.dart';
import 'package:vehicle_rental_app/utils/utils.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  Uint8List? imageAvatarEdit;

  @override
  Widget build(BuildContext context) {
    Get.closeCurrentSnackbar();
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.to(() => const ProfileScreen()),
              icon: const Icon(Icons.arrow_back)),
          title: const Text(
            "Cập nhật thông tin",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
                constraints: const BoxConstraints.expand(),
                color: Colors.white,
                child: FutureBuilder(
                  future: UserController.instance.getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      UserModel userData = snapshot.data as UserModel;
                      final name = TextEditingController(text: userData.name);
                      final email = TextEditingController(text: userData.email);
                      final phone = TextEditingController(text: userData.phone);
                      var imageUrl = userData.imageAvatar;
                      final password =
                          TextEditingController(text: userData.password);
                      final addressRoad =
                          TextEditingController(text: userData.addressRoad);
                      final addressDistrict =
                          TextEditingController(text: userData.addressDistrict);
                      final addressCity =
                          TextEditingController(text: userData.addressCity);

                      return Column(children: [
                        GestureDetector(
                          onTap: () async {
                            Uint8List? imgAvatar =
                                await Utils.pickImage(ImageSource.gallery);
                            if (imgAvatar != null) {
                              setState(() {
                                imageAvatarEdit = imgAvatar;
                                imageUrl = null;
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
                                            image:
                                                MemoryImage(imageAvatarEdit!),
                                          )
                                        : imageUrl != null
                                            ? Image.network(imageUrl)
                                            : Image.asset(
                                                "lib/assets/images/no_avatar.png"),
                                  )),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.amber,
                                  ),
                                  child: const Icon(Icons.camera_alt, size: 20),
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
                                  controller: email,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.email_outlined),
                                      labelText: 'Email',
                                      border: OutlineInputBorder(),
                                      labelStyle: TextStyle(
                                        color: Color(0xff888888),
                                      )),
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
                                      labelStyle: TextStyle(
                                        color: Color(0xff888888),
                                      )),
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
                                const SizedBox(height: 15),
                                const Text("Địa chỉ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: addressRoad,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.location_on),
                                      labelText: 'Số nhà, tên đường',
                                      border: OutlineInputBorder(),
                                      labelStyle: TextStyle(
                                        color: Color(0xff888888),
                                      )),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: addressDistrict,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.location_on),
                                      labelText: 'Quận/Huyện',
                                      border: OutlineInputBorder(),
                                      labelStyle: TextStyle(
                                        color: Color(0xff888888),
                                      )),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: addressCity,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.location_on),
                                      labelText: 'Tỉnh/Thành phố',
                                      border: OutlineInputBorder(),
                                      labelStyle: TextStyle(
                                        color: Color(0xff888888),
                                      )),
                                ),
                                const SizedBox(height: 30),
                                SizedBox(
                                  width: double.infinity,
                                  height: 56,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (email.text.trim().isEmpty ||
                                          name.text.trim().isEmpty ||
                                          phone.text.trim().isEmpty ||
                                          addressRoad.text.trim().isEmpty ||
                                          addressDistrict.text.trim().isEmpty ||
                                          addressCity.text.trim().isEmpty) {
                                        Get.closeCurrentSnackbar();
                                        Get.showSnackbar(GetSnackBar(
                                          messageText: const Text(
                                            "Vui lòng điền đầy đủ thông tin!",
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
                                        final user = UserModel(
                                          email: email.text.trim(),
                                          name: name.text.trim(),
                                          phone: phone.text.trim(),
                                          password: password.text.trim(),
                                          addressRoad: addressRoad.text.trim(),
                                          addressDistrict:
                                              addressDistrict.text.trim(),
                                          addressCity: addressCity.text.trim(),
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
                                        );
                                        if (imageAvatarEdit != null) {
                                          await UserController.instance
                                              .updateUserWithImage(
                                                  user, imageAvatarEdit!);
                                        } else {
                                          await UserController.instance
                                              .updateUser(user);
                                        }
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
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ]);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            )
          ],
        ));
  }
}
