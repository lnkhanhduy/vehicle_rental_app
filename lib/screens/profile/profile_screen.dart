import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/profile_controller.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/repository/user_repository.dart';
import 'package:vehicle_rental_app/screens/car/approve_screen.dart';
import 'package:vehicle_rental_app/screens/profile/change_password_screen.dart';
import 'package:vehicle_rental_app/screens/upload_image_info/id_card_screen.dart';
import 'package:vehicle_rental_app/screens/upload_image_info/license_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    Get.closeCurrentSnackbar();
    return Scaffold(
        appBar: AppBar(
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
                  padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                  constraints: const BoxConstraints.expand(),
                  color: Colors.white,
                  child: FutureBuilder(
                      future: controller.getUserData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          UserModel userData = snapshot.data as UserModel;
                          final name = userData.name;
                          final imageUrl = userData.imageAvatar;
                          final isAdmin = userData.isAdmin;
                          final isIdCardVerified = userData.isIdCardVerified;
                          final isLicenseVerified = userData.isLicenseVerified;
                          final providerId = UserRepository.instance
                              .firebaseUser.value?.providerData[0].providerId;
                          final provider = userData.provider;
                          return Column(children: [
                            SizedBox(
                                width: 100,
                                height: 100,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100)),
                                  child: (imageUrl != null && imageUrl != "")
                                      ? Image(image: NetworkImage(imageUrl!))
                                      : Image.asset(
                                          "lib/assets/images/no_avatar.png",
                                        ),
                                )),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              name,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 10,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Column(children: [
                                if (isAdmin != true)
                                  Column(children: [
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
                                            color:
                                                Colors.blue.withOpacity(0.1)),
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
                                          borderRadius:
                                              BorderRadius.circular(100),
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
                                            color:
                                                Colors.blue.withOpacity(0.1)),
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
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: isLicenseVerified == true
                                            ? const Icon(Icons.check,
                                                size: 30, color: Colors.green)
                                            : const Icon(Icons.error,
                                                size: 30, color: Colors.red),
                                      ),
                                    ),
                                  ]),
                                isAdmin == true
                                    ? Column(children: [
                                        ListTile(
                                          onTap: () {
                                            Get.to(() => const ApproveScreen());
                                          },
                                          leading: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                color: Colors.blue
                                                    .withOpacity(0.1)),
                                            child: const Icon(
                                                Icons.car_crash_outlined,
                                                color: Colors.blue),
                                          ),
                                          title: Text(
                                            "Duyệt xe",
                                            style:
                                                const TextStyle(fontSize: 17),
                                          ),
                                          trailing: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                color: Colors.grey
                                                    .withOpacity(0.1)),
                                            child: const Icon(
                                                Icons.chevron_right,
                                                size: 18,
                                                color: Colors.grey),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Divider(
                                            height: 1,
                                          ),
                                        ),
                                      ])
                                    : Container(),
                                Column(
                                  children: [
                                    isAdmin == false &&
                                            (provider == "password" &&
                                                    providerId == "password" ||
                                                (providerId == "google.com" &&
                                                    provider != "password"))
                                        ? const Divider()
                                        : Container(),
                                    if (provider == "password" &&
                                            providerId == "password" ||
                                        (providerId == "google.com" &&
                                            provider != "password"))
                                      ListTile(
                                        onTap: () {
                                          Get.to(() =>
                                              const ChangePasswordScreen());
                                        },
                                        leading: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color:
                                                  Colors.blue.withOpacity(0.1)),
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
                                              color:
                                                  Colors.grey.withOpacity(0.1)),
                                          child: const Icon(Icons.chevron_right,
                                              size: 18, color: Colors.grey),
                                        ),
                                      ),
                                  ],
                                ),
                              ]),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextButton(
                              onPressed: () {
                                UserRepository.instance.logoutUser();
                              },
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Transform.rotate(
                                      angle: 180 * 3.14 / 180,
                                      child: const Icon(Icons.logout,
                                          color: Colors.red),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    const Text(
                                      'Đăng xuất',
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.red),
                                    )
                                  ]),
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
