import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/profile_controller.dart';
import 'package:vehicle_rental_app/models/user_model.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    Get.closeCurrentSnackbar();
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
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
                  future: controller.getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      UserModel userData = snapshot.data as UserModel;
                      final name = TextEditingController(text: userData.name);
                      final email = TextEditingController(text: userData.email);
                      final phone = TextEditingController(text: userData.phone);
                      final imageUrl = userData.imageAvatar;
                      final password =
                          TextEditingController(text: userData.password);
                      final address =
                          TextEditingController(text: userData.address);
                      return Column(children: [
                        Stack(
                          children: [
                            SizedBox(
                                width: 120,
                                height: 120,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100)),
                                  child: imageUrl == null
                                      ? Image.asset(
                                          "lib/assets/images/no_avatar.png",
                                        )
                                      : Image(image: NetworkImage(imageUrl)),
                                )),
                            // Positioned(
                            //   bottom: 0,
                            //   right: 0,
                            //   child: Container(
                            //     width: 35,
                            //     height: 35,
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(100),
                            //       color: Colors.amber,
                            //     ),
                            //     child: const Icon(Icons.camera_alt, size: 20),
                            //   ),
                            // )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Form(
                          child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    controller: email,
                                    readOnly: true,
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.black),
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.email_outlined),
                                        labelText: 'Email',
                                        border: OutlineInputBorder(),
                                        labelStyle: TextStyle(
                                            color: Color(0xff888888),
                                            fontSize: 16)),
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: name,
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.black),
                                    decoration: const InputDecoration(
                                        prefixIcon:
                                            Icon(Icons.person_outline_outlined),
                                        labelText: 'Họ và tên',
                                        border: OutlineInputBorder(),
                                        labelStyle: TextStyle(
                                            color: Color(0xff888888),
                                            fontSize: 16)),
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: phone,
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.black),
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.phone_outlined),
                                        labelText: 'Số điện thoại',
                                        border: OutlineInputBorder(),
                                        labelStyle: TextStyle(
                                            color: Color(0xff888888),
                                            fontSize: 16)),
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: address,
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.black),
                                    decoration: const InputDecoration(
                                        prefixIcon:
                                            Icon(Icons.location_on_outlined),
                                        labelText: 'Địa chỉ',
                                        border: OutlineInputBorder(),
                                        labelStyle: TextStyle(
                                            color: Color(0xff888888),
                                            fontSize: 16)),
                                  ),
                                  const SizedBox(height: 30),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 56,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        final user = UserModel(
                                          email: email.text.trim(),
                                          name: name.text.trim(),
                                          phone: phone.text.trim(),
                                          address: address.text.trim(),
                                          password: password.text.trim(),
                                          provider: userData.provider,
                                          typeLicense: userData.typeLicense,
                                          imageAvatar: userData.imageAvatar,
                                          imageLicenseFront:
                                              userData.imageLicenseFront,
                                          imageLicenseBack:
                                              userData.imageLicenseBack,
                                          imageIdCardFront:
                                              userData.imageIdCardFront,
                                          imageIdCardBack:
                                              userData.imageIdCardBack,
                                          isIdCardVerified:
                                              userData.isIdCardVerified,
                                          isLicenseVerified:
                                              userData.isLicenseVerified,
                                          isAdmin: userData.isAdmin,
                                        );
                                        await controller.updateUser(user);
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
                        ),
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
