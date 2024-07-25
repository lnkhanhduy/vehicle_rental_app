import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/screens/auth/change_password_screen.dart';
import 'package:vehicle_rental_app/screens/loading_screen.dart';
import 'package:vehicle_rental_app/screens/profile/change_profile_screen.dart';
import 'package:vehicle_rental_app/screens/profile/user_paper_screen.dart';
import 'package:vehicle_rental_app/screens/register_car/info_rental_screen.dart';
import 'package:vehicle_rental_app/screens/user/help_screen.dart';
import 'package:vehicle_rental_app/screens/user_rental/car_rental_screen.dart';
import 'package:vehicle_rental_app/screens/user_rental/request_rental_car_screen.dart';
import 'package:vehicle_rental_app/widgets/account_button.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final userController = Get.put(UserController());

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
                future: userController.getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoadingScreen();
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    UserModel? user = snapshot.data as UserModel;
                    final name = user.name;
                    final imageUrl = user.imageAvatar;
                    final providerId = userController
                        .firebaseUser.value?.providerData[0].providerId;
                    final provider = user.provider;
                    final isVerified = user.isVerified ?? false;

                    return Column(children: [
                      SizedBox(
                        width: 90,
                        height: 90,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100)),
                          child: (imageUrl != null && imageUrl != "")
                              ? Image(
                                  image: Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        "lib/assets/images/no_avatar.png",
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ).image,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  "lib/assets/images/no_avatar.png",
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        name,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => UserPaperScreen(user: user));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.verified,
                              color: isVerified ? Colors.green : Colors.grey,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(isVerified ? "Đã xác minh" : "Chưa xác minh",
                                style: TextStyle(
                                  fontSize: 15,
                                  color:
                                      isVerified ? Colors.green : Colors.grey,
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
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
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Divider(height: 0.5),
                              ),
                              AccountButton(
                                onTap: () {
                                  Get.to(() => UserPaperScreen(
                                        user: user,
                                        isEdit: true,
                                      ));
                                },
                                icon: Icons.quick_contacts_mail_outlined,
                                title: "Giấy tờ của tôi",
                                isVerified: isVerified,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Divider(height: 0.5),
                              ),
                              AccountButton(
                                onTap: () {
                                  Get.to(() => const InfoRentalScreen());
                                },
                                icon: Icons.car_rental_outlined,
                                title: "Đăng ký cho thuê xe",
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Divider(height: 0.5),
                              ),
                              AccountButton(
                                onTap: () {
                                  Get.to(() => const CarRentalScreen());
                                },
                                icon: Icons.directions_car_filled_outlined,
                                title: "Xe đã đăng ký cho thuê",
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Divider(height: 0.5),
                              ),
                              AccountButton(
                                onTap: () {
                                  Get.to(() => const RequestRentalCarScreen());
                                },
                                icon: Icons.question_mark_outlined,
                                title: "Yêu cầu thuê xe",
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
                                  Get.to(() => const ChangePasswordScreen());
                                },
                                icon: Icons.lock_reset_outlined,
                                title: provider == "password"
                                    ? "Đổi mật khẩu"
                                    : "Tạo mật khẩu mới")
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
                          AccountButton(
                              onTap: () {
                                Get.to(() => const HelpScreen());
                              },
                              icon: Icons.help_outline,
                              title: "Hỗ trợ khách hàng")
                        ]),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextButton(
                        onPressed: () {
                          userController.logout();
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
                  }
                  return Container();
                }),
          ),
        )
      ]),
    );
  }
}
