import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vehicle_rental_app/controllers/admin_controller.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/screens/layout_admin_screen.dart';
import 'package:vehicle_rental_app/screens/loading_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';
import 'package:vehicle_rental_app/utils/utils.dart';
import 'package:vehicle_rental_app/widgets/image_container.dart';

class UserPaperScreen extends StatefulWidget {
  final bool view;
  final bool isEdit;
  final String? title;
  late UserModel user;

  UserPaperScreen(
      {super.key,
      required this.user,
      this.view = false,
      this.isEdit = false,
      this.title});

  @override
  State<UserPaperScreen> createState() => _UserPaperScreenState();
}

class _UserPaperScreenState extends State<UserPaperScreen> {
  final adminController = Get.put(AdminController());
  final userController = Get.put(UserController());

  final message = TextEditingController();

  Uint8List? imageIdCardFront;
  Uint8List? imageLicenseFront;
  Uint8List? imageLicenseBack;
  Uint8List? imageIdCardBack;
  String? imageIdCardFrontUrl;
  String? imageIdCardBackUrl;
  String? imageLicenseFrontUrl;
  String? imageLicenseBackUrl;

  bool isLoading = false;

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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_outlined)),
        title: Text(
          widget.title ?? "Giấy tờ của tôi",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: isLoading == true
                ? LoadingScreen()
                : Container(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                    constraints: const BoxConstraints.expand(),
                    color: Colors.white,
                    child: Column(
                      children: [
                        if (widget.user.isVerified == true)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.verified, color: Colors.green),
                              SizedBox(width: 5),
                              Text(
                                "Đã xác minh",
                                style: TextStyle(color: Colors.green),
                              )
                            ],
                          )
                        else if (widget.user.isVerified != true &&
                            (widget.user.message == null ||
                                widget.user.message!.isEmpty) &&
                            widget.user.imageIdCardFront != null &&
                            widget.user.imageIdCardBack != null &&
                            widget.user.imageLicenseFront != null &&
                            widget.user.imageLicenseBack != null &&
                            widget.user.imageIdCardFront!.isNotEmpty &&
                            widget.user.imageIdCardBack!.isNotEmpty &&
                            widget.user.imageLicenseFront!.isNotEmpty &&
                            widget.user.imageLicenseBack!.isNotEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error_outline_outlined,
                                  color: Colors.amber),
                              SizedBox(width: 5),
                              Text("Chờ duyệt",
                                  style: TextStyle(color: Colors.amber))
                            ],
                          )
                        else if (widget.user.isVerified != true &&
                            widget.user.message != null &&
                            widget.user.message!.isNotEmpty)
                          Column(
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.error_outline, color: Colors.red),
                                  SizedBox(width: 5),
                                  Text("Từ chối",
                                      style: TextStyle(color: Colors.red))
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Lý do: ${widget.user.message!}',
                                style: const TextStyle(color: Colors.red),
                              )
                            ],
                          )
                        else
                          Column(
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.verified, color: Colors.grey),
                                  SizedBox(width: 5),
                                  Text("Chưa xác minh",
                                      style: TextStyle(color: Colors.grey))
                                ],
                              ),
                            ],
                          ),
                        const SizedBox(height: 15),
                        const Text(
                          "CCCD",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        ImageContainer(
                            title: "Mặt trước",
                            image: imageIdCardFront != null ||
                                imageIdCardFrontUrl != null,
                            height: 250,
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
                                          await Utils.pickImage(
                                              ImageSource.camera);
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
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                    height: 24,
                                    child: Transform.rotate(
                                      angle: 90 * 3.14 / 180,
                                      child: Image.asset(
                                        "lib/assets/icons/dash.png",
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      Uint8List? imgGallery =
                                          await Utils.pickImage(
                                              ImageSource.gallery);

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
                                    ),
                                  ),
                                ],
                              ),
                        const SizedBox(height: 10),
                        ImageContainer(
                            title: "Mặt sau",
                            image: imageIdCardBack != null ||
                                imageIdCardBackUrl != null,
                            height: 250,
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
                                          await Utils.pickImage(
                                              ImageSource.camera);
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
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                    height: 24,
                                    child: Transform.rotate(
                                      angle: 90 * 3.14 / 180,
                                      child: Image.asset(
                                        "lib/assets/icons/dash.png",
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      Uint8List? imgGallery =
                                          await Utils.pickImage(
                                              ImageSource.gallery);

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
                                    ),
                                  ),
                                ],
                              ),
                        const SizedBox(height: 5),
                        const Divider(),
                        const SizedBox(height: 8),
                        const Text(
                          "GPLX",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        ImageContainer(
                            title: "Mặt trước",
                            image: imageLicenseFront != null ||
                                imageLicenseFrontUrl != null,
                            height: 250,
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
                                          await Utils.pickImage(
                                              ImageSource.camera);
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
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                    height: 24,
                                    child: Transform.rotate(
                                      angle: 90 * 3.14 / 180,
                                      child: Image.asset(
                                        "lib/assets/icons/dash.png",
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      Uint8List? imgGallery =
                                          await Utils.pickImage(
                                              ImageSource.gallery);

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
                                    ),
                                  ),
                                ],
                              ),
                        const SizedBox(height: 10),
                        ImageContainer(
                            title: "Mặt sau",
                            image: imageLicenseBack != null ||
                                imageLicenseBackUrl != null,
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
                                          await Utils.pickImage(
                                              ImageSource.camera);
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
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                    height: 24,
                                    child: Transform.rotate(
                                      angle: 90 * 3.14 / 180,
                                      child: Image.asset(
                                        "lib/assets/icons/dash.png",
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      Uint8List? imgGallery =
                                          await Utils.pickImage(
                                              ImageSource.gallery);

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
                                    ),
                                  ),
                                ],
                              ),
                        const Divider(),
                        const SizedBox(height: 10),
                        if (widget.view == true &&
                            widget.user.isVerified != true &&
                            (widget.user.message == null ||
                                widget.user.message!.isEmpty))
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                  "Nhập lý do không duyệt (Nếu chọn từ chối)"),
                              const SizedBox(height: 5),
                              TextField(
                                controller: message,
                                maxLines: 4,
                                decoration: InputDecoration(
                                  hintText: 'Nhập lý do không duyệt',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
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
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (message.text.trim().isEmpty) {
                                          Utils.showSnackBar(
                                            "Vui lòng nhập lý do từ chối.",
                                            Colors.red,
                                            Icons.error,
                                          );
                                        } else {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          bool result =
                                              await adminController.cancelUser(
                                                  widget.user.id!,
                                                  message.text.trim());
                                          if (result) {
                                            Utils.showSnackBar(
                                              "Từ chối thành công.",
                                              Colors.green,
                                              Icons.check,
                                            );
                                          }
                                          setState(() {
                                            isLoading = false;
                                          });
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                        ),
                                      ),
                                      child: const Text("Từ chối"),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        bool result = await adminController
                                            .approveUser(widget.user.id!);
                                        if (result) {
                                          Utils.showSnackBar(
                                              "Duyệt thành công.",
                                              Colors.green,
                                              Icons.check);
                                        }
                                        setState(() {
                                          isLoading = false;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Constants.primaryColor,
                                        foregroundColor: Colors.white,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                        ),
                                      ),
                                      child: const Text("Duyệt"),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        if ((widget.view == true &&
                                widget.user.isVerified == true) ||
                            (widget.view == true &&
                                widget.user.isVerified != true &&
                                widget.user.message != null &&
                                widget.user.message! != ""))
                          SizedBox(
                            width: double.infinity,
                            height: 46,
                            child: ElevatedButton(
                              onPressed: () async {
                                Get.to(() =>
                                    const LayoutAdminScreen(initialIndex: 1));
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
                                "Đóng",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        if (widget.view != true)
                          SizedBox(
                            width: double.infinity,
                            height: 46,
                            child: ElevatedButton(
                              onPressed: () async {
                                bool areUserImagesEmpty(UserModel user) {
                                  return (user.imageIdCardFront == null ||
                                          user.imageIdCardFront!.isEmpty) &&
                                      (user.imageIdCardBack == null ||
                                          user.imageIdCardBack!.isEmpty) &&
                                      (user.imageLicenseFront == null ||
                                          user.imageLicenseFront!.isEmpty) &&
                                      (user.imageLicenseBack == null ||
                                          user.imageLicenseBack!.isEmpty);
                                }

                                bool areAnyNewImagesNotEmpty() {
                                  return (imageIdCardFront != null &&
                                          imageIdCardFront!.isNotEmpty) ||
                                      (imageIdCardBack != null &&
                                          imageIdCardBack!.isNotEmpty) ||
                                      (imageLicenseFront != null &&
                                          imageLicenseFront!.isNotEmpty) ||
                                      (imageLicenseBack != null &&
                                          imageLicenseBack!.isNotEmpty);
                                }

                                if (widget.user.isVerified == true &&
                                    (imageIdCardFront != null ||
                                        imageIdCardBack != null ||
                                        imageLicenseFront != null ||
                                        imageLicenseBack != null)) {
                                  showConfirmationDialog();
                                } else if (areUserImagesEmpty(widget.user) ||
                                    areAnyNewImagesNotEmpty()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  bool result =
                                      await userController.updatePaper(
                                          imageIdCardFront,
                                          imageIdCardBack,
                                          imageLicenseFront,
                                          imageLicenseBack);

                                  if (result) {
                                    Utils.showSnackBar(
                                      "Tải hình ảnh lên thành công.",
                                      Colors.green,
                                      Icons.check,
                                    );
                                    final user =
                                        await userController.getUserData();
                                    setState(() {
                                      widget.user = user!;
                                      isLoading = false;
                                    });
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                } else {
                                  Utils.showSnackBar(
                                    "Vui lòng tải lên đầy đủ ảnh.",
                                    Colors.red,
                                    Icons.error,
                                  );
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
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> showConfirmationDialog() async {
    await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Xác nhận cập nhật'),
          content: const Text(
            'Giấy tờ của bạn đã được duyệt.\nNếu cập nhật bạn sẽ phải chờ duyệt lại.\nBạn có chắc muốn cập nhật không?',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Hủy', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child:
                  const Text('Cập nhật', style: TextStyle(color: Colors.blue)),
              onPressed: () async {
                Navigator.of(context).pop(true);
                setState(() {
                  isLoading = true;
                });
                bool result = await userController.updatePaper(imageIdCardFront,
                    imageIdCardBack, imageLicenseFront, imageLicenseBack);
                if (result) {
                  Utils.showSnackBar(
                    "Tải hình ảnh lên thành công.",
                    Colors.green,
                    Icons.check,
                  );
                  final user = await userController.getUserData();
                  setState(() {
                    widget.user = user!;
                    isLoading = false;
                  });
                } else {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }
}
