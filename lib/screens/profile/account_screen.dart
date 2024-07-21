import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/screens/auth/change_password_screen.dart';
import 'package:vehicle_rental_app/screens/profile/change_profile_screen.dart';
import 'package:vehicle_rental_app/screens/profile/user_paper_screen.dart';
import 'package:vehicle_rental_app/screens/user/history_screen.dart';
import 'package:vehicle_rental_app/screens/user_rental/car_rental_screen.dart';
import 'package:vehicle_rental_app/screens/user_rental/request_rental_car_screen.dart';
import 'package:vehicle_rental_app/widgets/account_button.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Tài khoản",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          leading: Container(),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
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
                          final isVerified = userData.isVerified;
                          final providerId = UserController.instance
                              .firebaseUser.value?.providerData[0].providerId;
                          final provider = userData.provider;
                          return Column(children: [
                            SizedBox(
                              width: 90,
                              height: 90,
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
                                            "lib/assets/images/no_avatar.png",
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ).image)
                                    : Image.asset(
                                        "lib/assets/images/no_avatar.png",
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
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
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AccountButton(
                                      onTap: () {
                                        Get.to(() => ChangeProfileScreen());
                                      },
                                      icon: Icons.account_circle_outlined,
                                      title: "Tài khoản của tôi",
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      child: Divider(height: 0.5),
                                    ),
                                    AccountButton(
                                      onTap: () {
                                        Get.to(() => UserPaperScreen(
                                              user: userData,
                                              isEdit: true,
                                            ));
                                      },
                                      icon: Icons.quick_contacts_mail_outlined,
                                      title: "Giấy tờ của tôi",
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      child: Divider(height: 0.5),
                                    ),
                                    AccountButton(
                                      onTap: () {
                                        Get.to(() => const CarRentalScreen());
                                      },
                                      icon:
                                          Icons.directions_car_filled_outlined,
                                      title: "Xe đã cho thuê",
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      child: Divider(height: 0.5),
                                    ),
                                    AccountButton(
                                      onTap: () {
                                        Get.to(() =>
                                            const RequestRentalCarScreen());
                                      },
                                      icon: Icons.question_mark_outlined,
                                      title: "Yêu cầu thuê xe",
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      child: Divider(height: 0.5),
                                    ),
                                    AccountButton(
                                      onTap: () {
                                        Get.to(() => const HistoryScreen());
                                      },
                                      icon: Icons.history_outlined,
                                      title: "Lịch sử",
                                    ),
                                  ]),
                            ),
                            const SizedBox(height: 20),
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
                                  AccountButton(
                                      onTap: () {
                                        Get.to(
                                            () => const ChangePasswordScreen());
                                      },
                                      icon: Icons.lock_reset_outlined,
                                      title: provider == "password"
                                          ? "Đổi mật khẩu"
                                          : "Tạo mật khẩu mới")
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
