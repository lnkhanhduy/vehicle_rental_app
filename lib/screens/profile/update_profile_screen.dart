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
  bool _obscureText = true;

  void _togglePasswordStatus() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

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
                      final password =
                          TextEditingController(text: userData.password);
                      final address =
                          TextEditingController(text: userData.address);
                      return Column(children: [
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
                                child: const Icon(Icons.camera_alt, size: 20),
                              ),
                            )
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
                                    controller: email,
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
                                    controller: password,
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.black),
                                    decoration: InputDecoration(
                                      labelText: 'Mật khẩu',
                                      border: const OutlineInputBorder(),
                                      labelStyle: const TextStyle(
                                          color: Color(0xff888888),
                                          fontSize: 16),
                                      prefixIcon: const Icon(Icons.fingerprint),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obscureText
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                        onPressed: _togglePasswordStatus,
                                      ),
                                    ),
                                    obscureText: _obscureText,
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
                                          id: userData.id,
                                          email: email.text.trim(),
                                          name: name.text.trim(),
                                          phone: phone.text.trim(),
                                          address: address.text.trim(),
                                          password: password.text.trim(),
                                          isAdmin: false,
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
