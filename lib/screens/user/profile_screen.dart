import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/screens/admin/approve_car_screen.dart';
import 'package:vehicle_rental_app/screens/admin/approve_user_paper_screen.dart';
import 'package:vehicle_rental_app/screens/user/change_password_screen.dart';
import 'package:vehicle_rental_app/screens/user/history_rental_screen.dart';
import 'package:vehicle_rental_app/screens/user/history_screen.dart';
import 'package:vehicle_rental_app/screens/user/update_profile_screen.dart';
import 'package:vehicle_rental_app/screens/user/user_paper_screen.dart';
import 'package:vehicle_rental_app/screens/user_rental/car_rental_screen.dart';
import 'package:vehicle_rental_app/screens/user_rental/info_rental_screen.dart';
import 'package:vehicle_rental_app/screens/user_rental/request_rental_car_screen.dart';

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
          title: const Text(
            "Thông tin",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                  padding: const EdgeInsets.all(20),
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
                          final providerId = UserController.instance
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
                                  fontSize: 17, fontWeight: FontWeight.bold),
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
                                    title: const Text("Duyệt xe"),
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
                                    title: const Text("Duyệt giấy tờ"),
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
                                        width: 34,
                                        height: 34,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color:
                                                Colors.blue.withOpacity(0.1)),
                                        child: const Icon(
                                          Icons.directions_car_filled_outlined,
                                          color: Colors.blue,
                                          size: 20,
                                        ),
                                      ),
                                      title: const Text('Đăng ký cho thuê xe'),
                                      trailing: Container(
                                        width: 24,
                                        height: 24,
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
                                        width: 34,
                                        height: 34,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color:
                                                Colors.blue.withOpacity(0.1)),
                                        child: const Icon(
                                          Icons.car_repair,
                                          color: Colors.blue,
                                          size: 20,
                                        ),
                                      ),
                                      title:
                                          const Text("Xe đã đăng ký cho thuê"),
                                      trailing: Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.grey.withOpacity(0.1),
                                        ),
                                        child: const Icon(Icons.chevron_right,
                                            size: 18, color: Colors.grey),
                                      ),
                                    ),
                                    const Divider(
                                      height: 1,
                                    ),
                                    ListTile(
                                      onTap: () {
                                        Get.to(() =>
                                            const RequestRentalCarScreen());
                                      },
                                      leading: Container(
                                        width: 34,
                                        height: 34,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color:
                                                Colors.blue.withOpacity(0.1)),
                                        child: const Icon(
                                          Icons.question_mark_outlined,
                                          color: Colors.blue,
                                          size: 20,
                                        ),
                                      ),
                                      title: const Text('Yêu cầu thuê xe'),
                                      trailing: Container(
                                        width: 24,
                                        height: 24,
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
                                      Get.to(() => const HistoryScreen());
                                    },
                                    leading: Container(
                                      width: 34,
                                      height: 34,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.blue.withOpacity(0.1)),
                                      child: const Icon(
                                        Icons.history_outlined,
                                        color: Colors.blue,
                                        size: 20,
                                      ),
                                    ),
                                    title: const Text("Lịch sử thuê xe"),
                                    trailing: Container(
                                      width: 24,
                                      height: 24,
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
                                      Get.to(() => const HistoryRentalScreen());
                                    },
                                    leading: Container(
                                      width: 34,
                                      height: 34,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.blue.withOpacity(0.1)),
                                      child: const Icon(
                                        Icons.history_outlined,
                                        color: Colors.blue,
                                        size: 20,
                                      ),
                                    ),
                                    title: const Text('Lịch sử cho thuê xe'),
                                    trailing: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Colors.grey.withOpacity(0.1),
                                      ),
                                      child: const Icon(Icons.chevron_right,
                                          size: 18, color: Colors.grey),
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
                                  ListTile(
                                    onTap: () {
                                      Get.to(() => const UpdateProfileScreen());
                                    },
                                    leading: Container(
                                      width: 34,
                                      height: 34,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.blue.withOpacity(0.1)),
                                      child: const Icon(
                                        Icons.account_circle_outlined,
                                        color: Colors.blue,
                                        size: 20,
                                      ),
                                    ),
                                    title: const Text("Tài khoản của tôi"),
                                    trailing: Container(
                                      width: 24,
                                      height: 24,
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
                                      width: 34,
                                      height: 34,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.blue.withOpacity(0.1)),
                                      child: const Icon(
                                        Icons.quick_contacts_mail_outlined,
                                        color: Colors.blue,
                                        size: 20,
                                      ),
                                    ),
                                    title: const Text('Cập nhật giấy tờ'),
                                    trailing: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: isVerified == true
                                          ? const Icon(Icons.check_circle,
                                              size: 24, color: Colors.green)
                                          : const Icon(Icons.error,
                                              size: 24, color: Colors.red),
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
                                        width: 34,
                                        height: 34,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color:
                                                Colors.blue.withOpacity(0.1)),
                                        child: const Icon(
                                          Icons.lock_reset_outlined,
                                          color: Colors.blue,
                                          size: 20,
                                        ),
                                      ),
                                      title: Text(provider == "password"
                                          ? "Đổi mật khẩu"
                                          : "Tạo mật khẩu mới"),
                                      trailing: Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color:
                                                Colors.grey.withOpacity(0.1)),
                                        child: const Icon(Icons.chevron_right,
                                            size: 20, color: Colors.grey),
                                      ),
                                    ),
                                ]),
                              ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextButton(
                              onPressed: () {
                                UserController.instance.logout();
                              },
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Transform.rotate(
                                      angle: 180 * 3.14 / 180,
                                      child: const Icon(
                                        Icons.logout,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    const Text(
                                      'Đăng xuất',
                                      style: TextStyle(color: Colors.red),
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
