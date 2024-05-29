import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/repository/authentication_repository.dart';
import 'package:vehicle_rental_app/screens/profile/update_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
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
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
                constraints: const BoxConstraints.expand(),
                color: Colors.white,
                child: Column(children: [
                  Stack(
                    children: [
                      const SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            child: Image(
                                image: NetworkImage(
                                    'https://plus.unsplash.com/premium_photo-1666788167996-640dc3c4157e?q=80&w=1911&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'))),
                      ),
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
                          child: const Icon(Icons.edit, size: 20),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Lê Nguyễn Khánh Duy",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "duy@gmail.com",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => const UpdateProfileScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text(
                          'Sửa thông tin',
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.blue.withOpacity(0.1)),
                      child: const Icon(Icons.car_rental, color: Colors.blue),
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
                          color: Colors.grey.withOpacity(0.1)),
                      child: const Icon(Icons.chevron_right,
                          size: 18, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    onTap: () {
                      AuthenticationRepository.instance.logoutUser();
                    },
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.blue.withOpacity(0.1)),
                      child: const Icon(Icons.logout, color: Colors.blue),
                    ),
                    title: const Text(
                      'Đăng xuất',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ]),
              ),
            )
          ],
        ));
  }
}
