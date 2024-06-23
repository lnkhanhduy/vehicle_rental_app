import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/screens/approve_user_paper_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';
import 'package:vehicle_rental_app/utils/utils.dart';
import 'package:vehicle_rental_app/widgets/image_container.dart';

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
    final message = TextEditingController();

    Get.closeCurrentSnackbar();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
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
              if (widget.view != true && widget.user.isVerified == true)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, color: Colors.green),
                    SizedBox(width: 5),
                    Text("Đã duyệt", style: TextStyle(color: Colors.green))
                  ],
                )
              else if (widget.view != true &&
                  widget.user.isVerified == false &&
                  (widget.user.message == null || widget.user.message!.isEmpty))
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.warning_amber_outlined, color: Colors.amber),
                    SizedBox(width: 5),
                    Text("Chờ duyệt", style: TextStyle(color: Colors.amber))
                  ],
                )
              else if (widget.view != true &&
                  widget.user.isVerified != true &&
                  widget.user.message != null &&
                  widget.user.message!.isNotEmpty)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, color: Colors.red),
                        SizedBox(width: 5),
                        Text("Từ chối", style: TextStyle(color: Colors.red))
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Lý do: ${widget.user.message!}',
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
              const SizedBox(
                height: 25,
              ),
              const Text("CCCD",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              const SizedBox(
                height: 10,
              ),
              ImageContainer(
                  title: "Mặt trước",
                  image:
                      imageIdCardFront != null || imageIdCardFrontUrl != null,
                  height: 250.0,
                  width: MediaQuery.of(context).size.width,
                  imageUnit8List: imageIdCardFront,
                  imageUrl: imageIdCardFrontUrl,
                  imageAsset: 'lib/assets/icons/camera_upload.png'),
              widget.view == true
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () async {
                              Uint8List? imgCamera =
                                  await Utils.pickImage(ImageSource.camera);
                              if (imgCamera != null) {
                                setState(() {
                                  imageIdCardFront = imgCamera;
                                  imageIdCardFrontUrl = null;
                                });
                              }
                            },
                            icon: SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset(
                                "lib/assets/icons/camera_upload.png",
                              ),
                            )),
                        SizedBox(
                            width: 20,
                            height: 24,
                            child: Transform.rotate(
                              angle: 90 * 3.14 / 180,
                              child: Image.asset(
                                "lib/assets/icons/dash.png",
                                color: Colors.grey,
                              ),
                            )),
                        IconButton(
                            onPressed: () async {
                              Uint8List? imgGallery =
                                  await Utils.pickImage(ImageSource.gallery);

                              if (imgGallery != null) {
                                setState(() {
                                  imageIdCardFront = imgGallery;
                                  imageIdCardFrontUrl = null;
                                });
                              }
                            },
                            icon: SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset(
                                "lib/assets/icons/image_gallery.png",
                              ),
                            )),
                      ],
                    ),
              const SizedBox(height: 20),
              ImageContainer(
                  title: "Mặt sau",
                  image: imageIdCardBack != null || imageIdCardBackUrl != null,
                  height: 250.0,
                  width: MediaQuery.of(context).size.width,
                  imageUnit8List: imageIdCardBack,
                  imageUrl: imageIdCardBackUrl,
                  imageAsset: 'lib/assets/icons/camera_upload.png'),
              widget.view == true
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () async {
                              Uint8List? imgCamera =
                                  await Utils.pickImage(ImageSource.camera);
                              if (imgCamera != null) {
                                setState(() {
                                  imageIdCardBack = imgCamera;
                                  imageIdCardBackUrl = null;
                                });
                              }
                            },
                            icon: SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset(
                                "lib/assets/icons/camera_upload.png",
                              ),
                            )),
                        SizedBox(
                            width: 20,
                            height: 24,
                            child: Transform.rotate(
                              angle: 90 * 3.14 / 180,
                              child: Image.asset(
                                "lib/assets/icons/dash.png",
                                color: Colors.grey,
                              ),
                            )),
                        IconButton(
                            onPressed: () async {
                              Uint8List? imgGallery =
                                  await Utils.pickImage(ImageSource.gallery);

                              if (imgGallery != null) {
                                setState(() {
                                  imageIdCardBack = imgGallery;
                                  imageIdCardBackUrl = null;
                                });
                              }
                            },
                            icon: SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset(
                                "lib/assets/icons/image_gallery.png",
                              ),
                            )),
                      ],
                    ),
              const SizedBox(
                height: 15,
              ),
              const Divider(),
              const SizedBox(
                height: 15,
              ),
              const Text("GPLX",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              const SizedBox(
                height: 10,
              ),
              ImageContainer(
                  title: "Mặt trước",
                  image:
                      imageLicenseFront != null || imageLicenseFrontUrl != null,
                  height: 250.0,
                  width: MediaQuery.of(context).size.width,
                  imageUnit8List: imageLicenseFront,
                  imageUrl: imageLicenseFrontUrl,
                  imageAsset: 'lib/assets/icons/camera_upload.png'),
              widget.view == true
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () async {
                              Uint8List? imgCamera =
                                  await Utils.pickImage(ImageSource.camera);
                              if (imgCamera != null) {
                                setState(() {
                                  imageLicenseFront = imgCamera;
                                  imageLicenseFrontUrl = null;
                                });
                              }
                            },
                            icon: SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset(
                                "lib/assets/icons/camera_upload.png",
                              ),
                            )),
                        SizedBox(
                            width: 20,
                            height: 24,
                            child: Transform.rotate(
                              angle: 90 * 3.14 / 180,
                              child: Image.asset(
                                "lib/assets/icons/dash.png",
                                color: Colors.grey,
                              ),
                            )),
                        IconButton(
                            onPressed: () async {
                              Uint8List? imgGallery =
                                  await Utils.pickImage(ImageSource.gallery);

                              if (imgGallery != null) {
                                setState(() {
                                  imageLicenseFront = imgGallery;
                                  imageLicenseFrontUrl = null;
                                });
                              }
                            },
                            icon: SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset(
                                "lib/assets/icons/image_gallery.png",
                              ),
                            )),
                      ],
                    ),
              const SizedBox(height: 20),
              ImageContainer(
                  title: "Mặt sau",
                  image:
                      imageLicenseBack != null || imageLicenseBackUrl != null,
                  height: 250.0,
                  width: MediaQuery.of(context).size.width,
                  imageUnit8List: imageLicenseBack,
                  imageUrl: imageLicenseBackUrl,
                  imageAsset: 'lib/assets/icons/camera_upload.png'),
              widget.view == true
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () async {
                              Uint8List? imgCamera =
                                  await Utils.pickImage(ImageSource.camera);
                              if (imgCamera != null) {
                                setState(() {
                                  imageLicenseBack = imgCamera;
                                  imageLicenseBackUrl = null;
                                });
                              }
                            },
                            icon: SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset(
                                "lib/assets/icons/camera_upload.png",
                              ),
                            )),
                        SizedBox(
                            width: 20,
                            height: 24,
                            child: Transform.rotate(
                              angle: 90 * 3.14 / 180,
                              child: Image.asset(
                                "lib/assets/icons/dash.png",
                                color: Colors.grey,
                              ),
                            )),
                        IconButton(
                            onPressed: () async {
                              Uint8List? imgGallery =
                                  await Utils.pickImage(ImageSource.gallery);

                              if (imgGallery != null) {
                                setState(() {
                                  imageLicenseBack = imgGallery;
                                  imageLicenseBackUrl = null;
                                });
                              }
                            },
                            icon: SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset(
                                "lib/assets/icons/image_gallery.png",
                              ),
                            )),
                      ],
                    ),
              const SizedBox(
                height: 15,
              ),
              const Divider(),
              const SizedBox(
                height: 20,
              ),
              if (widget.view == true &&
                  widget.user.isVerified != true &&
                  (widget.user.message == null || widget.user.message!.isEmpty))
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Nhập lý do không duyệt (Nếu chọn từ chối)"),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: message,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Nhập lý do không duyệt',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.1),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: Constants.primaryColor,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12),
                      ),
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (message.text.trim().isEmpty) {
                                Get.closeCurrentSnackbar();
                                Get.showSnackbar(GetSnackBar(
                                  messageText: const Text(
                                    "Vui lòng nhập lý do từ chối!",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  backgroundColor: Colors.red,
                                  duration: const Duration(seconds: 10),
                                  icon: const Icon(Icons.error,
                                      color: Colors.white),
                                  onTap: (_) {
                                    Get.closeCurrentSnackbar();
                                  },
                                ));
                              } else {
                                await UserController.instance.cancelUser(
                                    widget.user.id!, message.text.trim());
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                            child: const Text("Từ chối"),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          child: ElevatedButton(
                            onPressed: () async {
                              await UserController.instance
                                  .approveUser(widget.user.id!);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Constants.primaryColor,
                              foregroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                            child: const Text("Duyệt"),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              if ((widget.view == true && widget.user.isVerified == true) ||
                  (widget.view == true &&
                      widget.user.isVerified != true &&
                      widget.user.message != null &&
                      widget.user.message!.isNotEmpty))
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      Get.to(() => const ApproveUserPaperScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                    child: const Text(
                      "ĐÓNG",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              if (widget.view != true)
                SizedBox(
                  width: double.infinity,
                  height: 50,
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
                        await UserController.instance.updatePaper(
                            imageIdCardFront,
                            imageIdCardBack,
                            imageLicenseFront,
                            imageLicenseBack);
                      } else {
                        Get.closeCurrentSnackbar();
                        Get.showSnackbar(GetSnackBar(
                          messageText: const Text(
                            "Vui lòng tải lên đầy đủ ảnh!",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Colors.red,
                          duration: const Duration(seconds: 10),
                          icon: const Icon(Icons.error, color: Colors.white),
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
            ]),
          ),
        ),
      ]),
    );
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
                await UserController.instance.updatePaper(imageIdCardFront,
                    imageIdCardBack, imageLicenseFront, imageLicenseBack);
              },
            ),
          ],
        );
      },
    );
  }
}