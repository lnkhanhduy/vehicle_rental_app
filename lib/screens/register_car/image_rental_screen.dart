import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/screens/layout_admin_screen.dart';
import 'package:vehicle_rental_app/screens/layout_screen.dart';
import 'package:vehicle_rental_app/screens/register_car/paper_rental_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';
import 'package:vehicle_rental_app/utils/utils.dart';
import 'package:vehicle_rental_app/widgets/header_register_car.dart';
import 'package:vehicle_rental_app/widgets/image_container.dart';

class ImageRentalScreen extends StatefulWidget {
  final CarModel car;
  final bool view;
  final bool isEdit;

  const ImageRentalScreen(
      {super.key, required this.car, this.view = false, this.isEdit = false});

  @override
  State<ImageRentalScreen> createState() => _ImageRentalScreenState();
}

class _ImageRentalScreenState extends State<ImageRentalScreen> {
  Uint8List? imageMain;
  Uint8List? imageInside;
  Uint8List? imageFront;
  Uint8List? imageBack;
  Uint8List? imageLeft;
  Uint8List? imageRight;
  String? imageMainUrl;
  String? imageInsideUrl;
  String? imageFrontUrl;
  String? imageBackUrl;
  String? imageLeftUrl;
  String? imageRightUrl;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit || widget.view) {
      imageMainUrl = widget.car.imageCarMain!;
      imageInsideUrl = widget.car.imageCarInside!;
      imageFrontUrl = widget.car.imageCarFront!;
      imageBackUrl = widget.car.imageCarBack!;
      imageLeftUrl = widget.car.imageCarLeft!;
      imageRightUrl = widget.car.imageCarRight!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_outlined)),
        title: const Text(
          "Hình ảnh",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          if (widget.view == false)
            IconButton(
              onPressed: () =>
                  Get.to(() => const LayoutScreen(initialIndex: 0)),
              icon: const Icon(
                Icons.home_outlined,
              ),
            ),
          if (widget.view == true)
            IconButton(
              onPressed: () =>
                  Get.to(() => const LayoutAdminScreen(initialIndex: 0)),
              icon: const Icon(
                Icons.home_outlined,
              ),
            )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              constraints: const BoxConstraints.expand(),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const HeaderRegisterCar(
                      imageScreen: true,
                      paperScreen: false,
                      priceScreen: false),
                  ImageContainer(
                      title: "Ảnh đại diện",
                      image: imageMain != null || imageMainUrl != null,
                      height: 250.0,
                      width: MediaQuery.of(context).size.width,
                      imageUnit8List: imageMain,
                      imageUrl: imageMainUrl,
                      imageAsset: 'lib/assets/icons/car_front.png'),
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
                                      imageMain = imgCamera;
                                      imageMainUrl = null;
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
                                    imageMain = imgGallery;
                                    imageMainUrl = null;
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
                  const SizedBox(height: 20),
                  ImageContainer(
                      title: "Ảnh bên trong xe",
                      image: imageInside != null || imageInsideUrl != null,
                      height: 250.0,
                      width: MediaQuery.of(context).size.width,
                      imageUnit8List: imageInside,
                      imageUrl: imageInsideUrl,
                      imageAsset: 'lib/assets/icons/car_front.png'),
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
                                    imageInside = imgCamera;
                                    imageInsideUrl = null;
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
                                )),
                            IconButton(
                                onPressed: () async {
                                  Uint8List? imgGallery = await Utils.pickImage(
                                      ImageSource.gallery);

                                  if (imgGallery != null) {
                                    setState(() {
                                      imageInside = imgGallery;
                                      imageInsideUrl = null;
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
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(children: [
                          ImageContainer(
                              title: "Ảnh trước",
                              image:
                                  imageFront != null || imageFrontUrl != null,
                              height: 130.0,
                              width: MediaQuery.of(context).size.width * 0.42,
                              imageUnit8List: imageFront,
                              imageUrl: imageFrontUrl,
                              imageAsset: 'lib/assets/icons/car_front.png'),
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
                                              imageFront = imgCamera;
                                              imageFrontUrl = null;
                                            });
                                          }
                                        },
                                        icon: SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: Image.asset(
                                            "lib/assets/icons/camera_upload.png",
                                          ),
                                        )),
                                    SizedBox(
                                        width: 18,
                                        height: 18,
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
                                            await Utils.pickImage(
                                                ImageSource.gallery);

                                        if (imgGallery != null) {
                                          setState(() {
                                            imageFront = imgGallery;
                                            imageFrontUrl = null;
                                          });
                                        }
                                      },
                                      icon: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: Image.asset(
                                          "lib/assets/icons/image_gallery.png",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                          const SizedBox(height: 15),
                          ImageContainer(
                              title: "Ảnh trái",
                              image: imageLeft != null || imageLeftUrl != null,
                              height: 130.0,
                              width: MediaQuery.of(context).size.width * 0.42,
                              imageUnit8List: imageLeft,
                              imageUrl: imageLeftUrl,
                              imageAsset: 'lib/assets/icons/car_left.png'),
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
                                              imageLeft = imgCamera;
                                              imageLeftUrl = null;
                                            });
                                          }
                                        },
                                        icon: SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: Image.asset(
                                            "lib/assets/icons/camera_upload.png",
                                          ),
                                        )),
                                    SizedBox(
                                        width: 18,
                                        height: 18,
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
                                            await Utils.pickImage(
                                                ImageSource.gallery);

                                        if (imgGallery != null) {
                                          setState(() {
                                            imageLeft = imgGallery;
                                            imageLeftUrl = null;
                                          });
                                        }
                                      },
                                      icon: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: Image.asset(
                                          "lib/assets/icons/image_gallery.png",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ]),
                        Column(
                          children: [
                            ImageContainer(
                                title: "Ảnh sau",
                                image:
                                    imageBack != null || imageBackUrl != null,
                                height: 130.0,
                                width: MediaQuery.of(context).size.width * 0.42,
                                imageUnit8List: imageBack,
                                imageUrl: imageFrontUrl,
                                imageAsset: 'lib/assets/icons/car_back.png'),
                            widget.view == true
                                ? Container()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            Uint8List? imgCamera =
                                                await Utils.pickImage(
                                                    ImageSource.camera);
                                            if (imgCamera != null) {
                                              setState(() {
                                                imageBack = imgCamera;
                                                imageBackUrl = null;
                                              });
                                            }
                                          },
                                          icon: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: Image.asset(
                                              "lib/assets/icons/camera_upload.png",
                                            ),
                                          )),
                                      SizedBox(
                                          width: 18,
                                          height: 18,
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
                                              await Utils.pickImage(
                                                  ImageSource.gallery);

                                          if (imgGallery != null) {
                                            setState(() {
                                              imageBack = imgGallery;
                                              imageBackUrl = null;
                                            });
                                          }
                                        },
                                        icon: SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: Image.asset(
                                            "lib/assets/icons/image_gallery.png",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                            const SizedBox(height: 15),
                            ImageContainer(
                                title: "Ảnh phải",
                                image:
                                    imageRight != null || imageRightUrl != null,
                                height: 130.0,
                                width: MediaQuery.of(context).size.width * 0.42,
                                imageUnit8List: imageRight,
                                imageUrl: imageRightUrl,
                                imageAsset: 'lib/assets/icons/car_right.png'),
                            widget.view == true
                                ? Container()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            Uint8List? imgCamera =
                                                await Utils.pickImage(
                                                    ImageSource.camera);
                                            if (imgCamera != null) {
                                              setState(() {
                                                imageRight = imgCamera;
                                                imageRightUrl = null;
                                              });
                                            }
                                          },
                                          icon: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: Image.asset(
                                              "lib/assets/icons/camera_upload.png",
                                            ),
                                          )),
                                      SizedBox(
                                          width: 18,
                                          height: 18,
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
                                              await Utils.pickImage(
                                                  ImageSource.gallery);

                                          if (imgGallery != null) {
                                            setState(() {
                                              imageRight = imgGallery;
                                              imageRightUrl = null;
                                            });
                                          }
                                        },
                                        icon: SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: Image.asset(
                                            "lib/assets/icons/image_gallery.png",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ],
                        )
                      ])
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        color: Constants.primaryColor.withOpacity(0.05),
        child: SizedBox(
          child: ElevatedButton(
            onPressed: () {
              if (widget.view == true) {
                Get.to(() => PaperRentalScreen(
                      car: widget.car,
                      view: true,
                    ));
              } else if (widget.isEdit == true) {
                Get.to(() => PaperRentalScreen(
                      car: widget.car,
                      isEdit: true,
                      imageCarMain: imageMain,
                      imageCarInside: imageInside,
                      imageCarFront: imageFront,
                      imageCarBack: imageBack,
                      imageCarLeft: imageLeft,
                      imageCarRight: imageRight,
                    ));
              } else if (imageMain == null ||
                  imageInside == null ||
                  imageFront == null ||
                  imageBack == null ||
                  imageLeft == null ||
                  imageRight == null) {
                Get.closeCurrentSnackbar();
                Get.showSnackbar(GetSnackBar(
                  messageText: const Text(
                    "Vui lòng chọn đầy đủ hình ảnh!",
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
              } else {
                Get.to(() => PaperRentalScreen(
                      car: widget.car,
                      imageCarMain: imageMain!,
                      imageCarInside: imageInside!,
                      imageCarFront: imageFront!,
                      imageCarBack: imageBack!,
                      imageCarLeft: imageLeft!,
                      imageCarRight: imageRight!,
                    ));
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Constants.primaryColor,
              foregroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            child: const Text(
              "Tiếp tục",
            ),
          ),
        ),
      ),
    );
  }
}
