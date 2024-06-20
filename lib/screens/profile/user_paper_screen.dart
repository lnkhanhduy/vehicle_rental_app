import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vehicle_rental_app/controllers/profile_controller.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/screens/profile/profile_screen.dart';
import 'package:vehicle_rental_app/utils/utils.dart';

class UserPaperScreen extends StatefulWidget {
  final bool view;
  final bool isEdit;
  final UserModel user;

  const UserPaperScreen(
      {super.key, required this.user, this.view = false, this.isEdit = false});

  @override
  State<UserPaperScreen> createState() => _UserPaperScreenState();
}

class _UserPaperScreenState extends State<UserPaperScreen> {
  Uint8List? imageIdCardFront;
  Uint8List? imageLicenseFront;
  Uint8List? imageLicenseBack;
  Uint8List? imageIdCardBack;
  String? imageIdCardFrontUrl;
  String? imageIdCardBackUrl;
  String? imageLicenseFrontUrl;
  String? imageLicenseBackUrl;

  @override
  void initState() {
    super.initState();

    if (widget.isEdit || widget.view) {
      imageIdCardFrontUrl = widget.user.imageIdCardFront;
      imageIdCardBackUrl = widget.user.imageIdCardBack;
      imageLicenseFrontUrl = widget.user.imageLicenseFront;
      imageLicenseBackUrl = widget.user.imageLicenseBack;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    Get.closeCurrentSnackbar();
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.to(() => ProfileScreen()),
              icon: const Icon(Icons.arrow_back)),
          title: const Text(
            "Thông tin giấy tờ",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 30),
                  constraints: const BoxConstraints.expand(),
                  color: Colors.white,
                  child: Column(children: [
                    Text("CCCD",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                    SizedBox(
                      height: 10,
                    ),
                    //Mặt trước
                    const Text(
                      "Mặt trước",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        Uint8List? imgIdCardFront =
                            await Utils.pickImage(ImageSource.gallery);
                        if (imgIdCardFront != null) {
                          setState(() {
                            imageIdCardFront = imgIdCardFront;
                            imageIdCardFrontUrl = null;
                          });
                        }
                      },
                      child: imageIdCardFront != null ||
                              imageIdCardFrontUrl != null
                          ? Container(
                              height: 200,
                              decoration: BoxDecoration(
                                image: imageIdCardFront != null
                                    ? DecorationImage(
                                        image: MemoryImage(imageIdCardFront!),
                                        fit: BoxFit.cover,
                                      )
                                    : (imageIdCardFrontUrl != null &&
                                            imageIdCardFrontUrl!.isNotEmpty)
                                        ? DecorationImage(
                                            image: NetworkImage(
                                              imageIdCardFrontUrl!,
                                            ),
                                            fit: BoxFit.cover,
                                          )
                                        : DecorationImage(
                                            image: Image.asset(
                                              "lib/assets/images/no_car_image.png",
                                            ).image,
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
                                border: Border.all(color: Colors.grey[400]!),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        Uint8List? imgIdCardBack =
                            await Utils.pickImage(ImageSource.gallery);
                        if (imgIdCardBack != null) {
                          setState(() {
                            imageIdCardBack = imgIdCardBack;
                            imageIdCardBackUrl = null;
                          });
                        }
                      },
                      child: imageIdCardBack != null ||
                              imageIdCardBackUrl != null
                          ? Container(
                              height: 200,
                              decoration: BoxDecoration(
                                image: imageIdCardBack != null
                                    ? DecorationImage(
                                        image: MemoryImage(imageIdCardBack!),
                                        fit: BoxFit.cover,
                                      )
                                    : imageIdCardBackUrl != null &&
                                            imageIdCardBackUrl!.isNotEmpty
                                        ? DecorationImage(
                                            image: NetworkImage(
                                                imageIdCardBackUrl!),
                                            fit: BoxFit.cover,
                                          )
                                        : DecorationImage(
                                            image: Image.asset(
                                              "lib/assets/images/no_car_image.png",
                                            ).image,
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
                                border: Border.all(color: Colors.grey[400]!),
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
                    SizedBox(
                      height: 25,
                    ),
                    Divider(),
                    SizedBox(
                      height: 15,
                    ),
                    Text("GPLX",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                    SizedBox(
                      height: 10,
                    ),
                    //Mặt trước
                    const Text(
                      "Mặt trước",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        Uint8List? imgLicenseFront =
                            await Utils.pickImage(ImageSource.gallery);
                        if (imgLicenseFront != null) {
                          setState(() {
                            imageLicenseFront = imgLicenseFront;
                            imageLicenseFrontUrl = null;
                          });
                        }
                      },
                      child: imageLicenseFront != null ||
                              imageLicenseFrontUrl != null
                          ? Container(
                              height: 200,
                              decoration: BoxDecoration(
                                image: imageLicenseFront != null
                                    ? DecorationImage(
                                        image: MemoryImage(imageLicenseFront!),
                                        fit: BoxFit.cover,
                                      )
                                    : imageLicenseFrontUrl != null &&
                                            imageLicenseFrontUrl!.isNotEmpty
                                        ? DecorationImage(
                                            image: NetworkImage(
                                              imageLicenseFrontUrl!,
                                            ),
                                            fit: BoxFit.cover,
                                          )
                                        : DecorationImage(
                                            image: Image.asset(
                                              "lib/assets/images/no_car_image.png",
                                            ).image,
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
                                border: Border.all(color: Colors.grey[400]!),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        Uint8List? imgLicenseBack =
                            await Utils.pickImage(ImageSource.gallery);
                        if (imgLicenseBack != null) {
                          setState(() {
                            imageLicenseBack = imgLicenseBack;
                            imageLicenseBackUrl = null;
                          });
                        }
                      },
                      child: imageLicenseBack != null ||
                              imageLicenseBackUrl != null
                          ? Container(
                              height: 200,
                              decoration: BoxDecoration(
                                image: imageLicenseBack != null
                                    ? DecorationImage(
                                        image: MemoryImage(imageLicenseBack!),
                                        fit: BoxFit.cover,
                                      )
                                    : imageLicenseBackUrl != null &&
                                            imageLicenseBackUrl!.isNotEmpty
                                        ? DecorationImage(
                                            image: NetworkImage(
                                                imageLicenseBackUrl!),
                                            fit: BoxFit.cover,
                                          )
                                        : DecorationImage(
                                            image: Image.asset(
                                              "lib/assets/images/no_car_image.png",
                                            ).image,
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
                                border: Border.all(color: Colors.grey[400]!),
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
                        onPressed: () async {
                          if (widget.user.isVerified == true &&
                              (imageIdCardFront != null ||
                                  imageIdCardBack != null ||
                                  imageLicenseFront != null ||
                                  imageLicenseBack != null)) {
                            _showConfirmationDialog();
                          } else if ((widget.user.imageIdCardFront == null &&
                                  widget.user.imageIdCardBack == null &&
                                  widget.user.imageLicenseFront == null &&
                                  widget.user.imageLicenseBack == null) ||
                              (widget.user.imageIdCardFront!.isEmpty &&
                                  widget.user.imageIdCardBack!.isEmpty &&
                                  widget.user.imageLicenseFront!.isEmpty &&
                                  widget.user.imageLicenseBack!.isEmpty)) {
                            await controller.updatePaper(
                                imageIdCardFront,
                                imageIdCardBack,
                                imageLicenseFront,
                                imageLicenseBack);
                          } else {
                            Get.closeCurrentSnackbar();
                            Get.showSnackbar(GetSnackBar(
                              messageText: Text(
                                "Vui lòng tải lên đầy đủ ảnh!",
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: Colors.red,
                              duration: const Duration(seconds: 10),
                              icon:
                                  const Icon(Icons.error, color: Colors.white),
                              onTap: (_) {
                                Get.closeCurrentSnackbar();
                              },
                            ));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87,
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                        ),
                        child: const Text(
                          "CẬP NHẬT",
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    )
                  ])))
        ]));
  }

  Future<void> _showConfirmationDialog() async {
    await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận cập nhật'),
          content: const Text(
              'Giấy tờ của bạn đã được xác minh.\nNếu cập nhật bạn sẽ phải chờ xác minh lại.\nBạn có chắc muốn cập nhật không?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Cập nhật'),
              onPressed: () async {
                Navigator.of(context).pop(true);
                await ProfileController.instance.updatePaper(imageIdCardFront,
                    imageIdCardBack, imageLicenseFront, imageLicenseBack);
              },
            ),
          ],
        );
      },
    );
  }
}
