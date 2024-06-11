import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vehicle_rental_app/controllers/profile_controller.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/utils/utils.dart';

class IdCardScreen extends StatefulWidget {
  const IdCardScreen({super.key});

  @override
  State<IdCardScreen> createState() => _IdCardScreenState();
}

class _IdCardScreenState extends State<IdCardScreen> {
  Uint8List? imageFront;
  Uint8List? imageBack;
  String? imageUrlFront;
  String? imageUrlBack;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
          title: const Text(
            "Thông tin CCCD",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                constraints: const BoxConstraints.expand(),
                color: Colors.white,
                child: FutureBuilder(
                  future: controller.getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      UserModel userData = snapshot.data as UserModel;
                      final isIdCardVerified = userData.isIdCardVerified;

                      if (imageFront == null) {
                        imageUrlFront = userData.imageIdCardFront;
                      }
                      if (imageBack == null) {
                        imageUrlBack = userData.imageIdCardBack;
                      }

                      return Column(children: [
                        //Mặt trước
                        const Text(
                          "Mặt trước",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        const SizedBox(height: 15),
                        GestureDetector(
                          onTap: () async {
                            Uint8List? imgFront =
                                await Utils.pickImage(ImageSource.gallery);
                            if (imgFront != null) {
                              setState(() {
                                imageFront = imgFront;
                                imageUrlFront = null;
                              });
                            }
                          },
                          child: imageFront != null ||
                                  (imageUrlFront != null &&
                                      imageUrlFront!.isNotEmpty)
                              ? Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    image: imageUrlFront != null
                                        ? DecorationImage(
                                            image: NetworkImage(
                                              imageUrlFront!,
                                            ),
                                            fit: BoxFit.cover,
                                          )
                                        : DecorationImage(
                                            image: MemoryImage(imageFront!),
                                            fit: BoxFit.cover,
                                          ),
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 8,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(16),
                                    border:
                                        Border.all(color: Colors.grey[400]!),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.add_a_photo,
                                      color: Colors.grey[400],
                                      size: 50,
                                    ),
                                  ),
                                ),
                        ),
                        const SizedBox(height: 20),
                        //Mặt sau
                        const Text(
                          "Mặt sau",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        const SizedBox(height: 15),
                        GestureDetector(
                          onTap: () async {
                            Uint8List? imgBack =
                                await Utils.pickImage(ImageSource.gallery);
                            if (imgBack != null) {
                              setState(() {
                                imageBack = imgBack;
                                imageUrlBack = null;
                              });
                            }
                          },
                          child: imageBack != null ||
                                  (imageUrlBack != null &&
                                      imageUrlBack!.isNotEmpty)
                              ? Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    image: imageUrlBack != null
                                        ? DecorationImage(
                                            image: NetworkImage(imageUrlBack!),
                                            fit: BoxFit.cover,
                                          )
                                        : DecorationImage(
                                            image: MemoryImage(imageBack!),
                                            fit: BoxFit.cover,
                                          ),
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 8,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(16),
                                    border:
                                        Border.all(color: Colors.grey[400]!),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.add_a_photo,
                                      color: Colors.grey[400],
                                      size: 50,
                                    ),
                                  ),
                                ),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              if (isIdCardVerified == true) {
                                _showConfirmationDialog();
                              } else {
                                controller.updateIdCard(imageFront, imageBack);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black87,
                              foregroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
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

  Future<void> _showConfirmationDialog() async {
    await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận cập nhật'),
          content: const Text(
              'CCCD của bạn đã được xác minh.\nNếu cập nhật bạn sẽ phải chờ xác minh lại.\nBạn có chắc muốn cập nhật không?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Cập nhật'),
              onPressed: () {
                Navigator.of(context).pop(true);
                ProfileController.instance.updateIdCard(imageFront, imageBack);
              },
            ),
          ],
        );
      },
    );
  }
}
