import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vehicle_rental_app/controllers/profile_controller.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/repository/user_repository.dart';
import 'package:vehicle_rental_app/screens/profile/change_password_screen.dart';
import 'package:vehicle_rental_app/screens/profile/update_profile_screen.dart';
import 'package:vehicle_rental_app/screens/upload_image_info/id_card_screen.dart';
import 'package:vehicle_rental_app/screens/upload_image_info/license_screen.dart';
import 'package:vehicle_rental_app/utils/utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Uint8List? image;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
          title: const Text(
            "Thông tin cá nhân",
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
                  child: FutureBuilder(
                      future: controller.getUserData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          UserModel userData = snapshot.data as UserModel;
                          final name = userData.name;
                          final email = userData.email;
                          final imageUrl = userData.imageAvatar;
                          final isAdmin = userData.isAdmin;
                          final isIdCardVerified = userData.isIdCardVerified;
                          final isLicenseVerified = userData.isLicenseVerified;
                          final providerId = UserRepository.instance
                              .firebaseUser.value?.providerData[0].providerId;
                          final provider = userData.provider;
                          return Column(children: [
                            Stack(
                              children: [
                                SizedBox(
                                  width: 120,
                                  height: 120,
                                  child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(100)),
                                      child: imageUrl == null || image == null
                                          ? Image.asset(
                                              "lib/assets/images/no_avatar.png",
                                            )
                                          : image != null
                                              ? Image(
                                                  image: MemoryImage(image!))
                                              : Image(
                                                  image:
                                                      NetworkImage(imageUrl))),
                                ),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: IconButton(
                                      icon: Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.blue,
                                        ),
                                        child: const Icon(
                                          Icons.edit,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: () async {
                                        Uint8List? img = await Utils.pickImage(
                                            ImageSource.gallery);
                                        if (img != null) {
                                          setState(() {
                                            image = img;
                                          });
                                          await Utils.uploadImage(
                                              image,
                                              UserRepository
                                                  .instance
                                                  .firebaseUser
                                                  .value
                                                  ?.providerData[0]
                                                  .email,
                                              "imageAvatar",
                                              "Users");

                                          Get.closeCurrentSnackbar();
                                          Get.showSnackbar(GetSnackBar(
                                            messageText: const Text(
                                              "Cập nhật ảnh đại diện thành công!",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            backgroundColor: Colors.green,
                                            duration:
                                                const Duration(seconds: 5),
                                            icon: const Icon(Icons.check,
                                                color: Colors.white),
                                            onTap: (_) {
                                              Get.closeCurrentSnackbar();
                                            },
                                          ));
                                        }
                                      },
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              name,
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              email,
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            if (isAdmin != true)
                              Column(children: [
                                SizedBox(
                                    width: 200,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Get.to(
                                            () => const UpdateProfileScreen());
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                      ),
                                      child: const Text(
                                        'Sửa thông tin',
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.white),
                                      ),
                                    )),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Divider(),
                                ListTile(
                                  onTap: () {
                                    Get.to(() => const IdCardScreen());
                                  },
                                  leading: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Colors.blue.withOpacity(0.1)),
                                    child: const Icon(
                                        Icons.contact_emergency_outlined,
                                        color: Colors.blue),
                                  ),
                                  title: const Text(
                                    "Cập nhật CCCD",
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  trailing: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: isIdCardVerified == true
                                        ? const Icon(Icons.check,
                                            size: 30, color: Colors.green)
                                        : const Icon(Icons.error,
                                            size: 30, color: Colors.red),
                                  ),
                                ),
                                const Divider(),
                                ListTile(
                                  onTap: () {
                                    Get.to(() => const LicenseScreen());
                                  },
                                  leading: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Colors.blue.withOpacity(0.1)),
                                    child: const Icon(Icons.car_rental,
                                        color: Colors.blue),
                                  ),
                                  title: const Text(
                                    'Cập nhật bằng lái xe',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  trailing: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: isLicenseVerified == true
                                        ? const Icon(Icons.check,
                                            size: 30, color: Colors.green)
                                        : const Icon(Icons.error,
                                            size: 30, color: Colors.red),
                                  ),
                                ),
                              ]),
                            Column(
                              children: [
                                provider == "password" &&
                                            providerId == "password" ||
                                        (providerId == "google.com" &&
                                            provider != "password")
                                    ? const Divider()
                                    : Container(),
                                if (provider == "password" &&
                                        providerId == "password" ||
                                    (providerId == "google.com" &&
                                        provider != "password"))
                                  ListTile(
                                    onTap: () {
                                      Get.to(
                                          () => const ChangePasswordScreen());
                                    },
                                    leading: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.blue.withOpacity(0.1)),
                                      child: const Icon(
                                          Icons.lock_reset_outlined,
                                          color: Colors.blue),
                                    ),
                                    title: Text(
                                      provider == "password"
                                          ? "Đổi mật khẩu"
                                          : "Tạo mật khẩu mới",
                                      style: const TextStyle(fontSize: 17),
                                    ),
                                    trailing: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.grey.withOpacity(0.1)),
                                      child: const Icon(Icons.chevron_right,
                                          size: 18, color: Colors.grey),
                                    ),
                                  ),
                              ],
                            ),
                            const Divider(),
                            ListTile(
                              onTap: () {
                                UserRepository.instance.logoutUser();
                              },
                              leading: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.blue.withOpacity(0.1)),
                                child: const Icon(Icons.logout,
                                    color: Colors.blue),
                              ),
                              title: const Text(
                                'Đăng xuất',
                                style: TextStyle(fontSize: 17),
                              ),
                            )
                          ]);
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      })))
        ]));
  }
}
