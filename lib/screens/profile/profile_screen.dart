import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/repository/user_repository.dart';
import 'package:vehicle_rental_app/screens/approve_user_paper_screen.dart';
import 'package:vehicle_rental_app/screens/car/approve_car_screen.dart';
import 'package:vehicle_rental_app/screens/car/car_rental_screen.dart';
import 'package:vehicle_rental_app/screens/car/register/info_rental_screen.dart';
import 'package:vehicle_rental_app/screens/layout_screen.dart';
import 'package:vehicle_rental_app/screens/profile/change_password_screen.dart';
import 'package:vehicle_rental_app/screens/profile/update_profile_screen.dart';
import 'package:vehicle_rental_app/screens/profile/user_paper_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    Get.closeCurrentSnackbar();
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.to(() => const LayoutScreen(
                    initialIndex: 0,
                  )),
              icon: const Icon(Icons.arrow_back)),
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
                      future: UserController.instance.getUserData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          UserModel userData = snapshot.data as UserModel;
                          final name = userData.name;
                          final imageUrl = userData.imageAvatar;
                          final isAdmin = userData.isAdmin;
                          final isVerified = userData.isVerified;
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
                                      ? Image(
                                          image: Image.network(
                                          imageUrl,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              "lib/assets/images/no_image.png",
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        ).image)
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
                            if (isAdmin == true)
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
                                  ListTile(
                                    onTap: () {
                                      Get.to(() => const ApproveCarScreen());
                                    },
                                    leading: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.blue.withOpacity(0.1)),
                                      child: const Icon(
                                          Icons.car_crash_outlined,
                                          color: Colors.blue),
                                    ),
                                    title: const Text(
                                      "Duyệt xe",
                                      style: TextStyle(fontSize: 17),
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
                                  const Divider(
                                    height: 1,
                                  ),
                                  ListTile(
                                    onTap: () {
                                      Get.to(
                                          () => const ApproveUserPaperScreen());
                                    },
                                    leading: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.blue.withOpacity(0.1)),
                                      child: const Icon(
                                          Icons.manage_accounts_outlined,
                                          color: Colors.blue),
                                    ),
                                    title: const Text(
                                      "Duyệt giấy tờ",
                                      style: TextStyle(fontSize: 17),
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
                                ]),
                              ),
                            if (isAdmin != true)
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
                                    ListTile(
                                      onTap: () {
                                        Get.to(() => const InfoRentalScreen());
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
                                            Icons
                                                .directions_car_filled_outlined,
                                            color: Colors.blue),
                                      ),
                                      title: const Text(
                                        'Đăng ký cho thuê xe',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      trailing: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.grey.withOpacity(0.1),
                                        ),
                                        child: const Icon(Icons.chevron_right,
                                            size: 18, color: Colors.grey),
                                      ),
                                    ),
                                    const Divider(height: 1),
                                    ListTile(
                                      onTap: () {
                                        Get.to(() => const CarRentalScreen());
                                      },
                                      leading: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color:
                                                Colors.blue.withOpacity(0.1)),
                                        child: const Icon(Icons.car_repair,
                                            color: Colors.blue),
                                      ),
                                      title: const Text(
                                        "Xe đã cho thuê",
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      trailing: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.grey.withOpacity(0.1),
                                        ),
                                        child: const Icon(Icons.chevron_right,
                                            size: 18, color: Colors.grey),
                                      ),
                                    ),
                                  ])),
                            if (isAdmin != true) const SizedBox(height: 20),
                            if (isAdmin != true)
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
                                  ListTile(
                                    onTap: () {
                                      Get.to(() => const UpdateProfileScreen());
                                    },
                                    leading: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.blue.withOpacity(0.1)),
                                      child: const Icon(
                                          Icons.account_circle_outlined,
                                          color: Colors.blue),
                                    ),
                                    title: const Text(
                                      "Tài khoản của tôi",
                                      style: TextStyle(fontSize: 17),
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
                                  const Divider(
                                    height: 1,
                                  ),
                                  ListTile(
                                    onTap: () {
                                      Get.to(() => UserPaperScreen(
                                            user: userData,
                                            isEdit: true,
                                          ));
                                    },
                                    leading: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.blue.withOpacity(0.1)),
                                      child: const Icon(
                                          Icons.quick_contacts_mail_outlined,
                                          color: Colors.blue),
                                    ),
                                    title: const Text(
                                      'Cập nhật giấy tờ',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    trailing: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: isVerified == true
                                          ? const Icon(Icons.check_circle,
                                              size: 30, color: Colors.green)
                                          : const Icon(Icons.error,
                                              size: 30, color: Colors.red),
                                    ),
                                  ),
                                ]),
                              ),
                            if (isAdmin != true) const SizedBox(height: 20),
                            if (isAdmin != true)
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
