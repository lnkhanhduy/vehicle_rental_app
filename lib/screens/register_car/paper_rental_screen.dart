import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/screens/layout_admin_screen.dart';
import 'package:vehicle_rental_app/screens/layout_screen.dart';
import 'package:vehicle_rental_app/screens/register_car/price_rental_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';
import 'package:vehicle_rental_app/utils/utils.dart';
import 'package:vehicle_rental_app/widgets/header_register_car.dart';
import 'package:vehicle_rental_app/widgets/image_container.dart';

class PaperRentalScreen extends StatefulWidget {
  final CarModel car;
  final bool isEdit;
  final bool view;
  final Uint8List? imageCarMain;
  final Uint8List? imageCarInside;
  final Uint8List? imageCarFront;
  final Uint8List? imageCarBack;
  final Uint8List? imageCarLeft;
  final Uint8List? imageCarRight;

  const PaperRentalScreen(
      {super.key,
      required this.car,
      this.isEdit = false,
      this.view = false,
      this.imageCarMain,
      this.imageCarInside,
      this.imageCarFront,
      this.imageCarBack,
      this.imageCarLeft,
      this.imageCarRight});

  @override
  State<PaperRentalScreen> createState() => _PaperRentalScreenState();
}

class _PaperRentalScreenState extends State<PaperRentalScreen> {
  Uint8List? imageRegistrationCertificate;
  Uint8List? imageCarInsurance;
  String? imageRegistrationCertificateUrl;
  String? imageCarInsuranceUrl;

  @override
  void initState() {
    super.initState();

    if (widget.isEdit || widget.view) {
      imageRegistrationCertificateUrl = widget.car.imageRegistrationCertificate;
      imageCarInsuranceUrl = widget.car.imageCarInsurance;
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.closeCurrentSnackbar();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_outlined)),
        title: const Text(
          "Giấy tờ",
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
                      imageScreen: true, paperScreen: true, priceScreen: false),
                  ImageContainer(
                      title: "Giấy đăng ký xe",
                      image: imageRegistrationCertificate != null ||
                          imageRegistrationCertificateUrl != null,
                      height: 250.0,
                      width: MediaQuery.of(context).size.width,
                      imageUnit8List: imageRegistrationCertificate,
                      imageUrl: imageRegistrationCertificateUrl,
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
                                      imageRegistrationCertificate = imgCamera;
                                      imageRegistrationCertificateUrl = null;
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
                                    imageRegistrationCertificate = imgGallery;
                                    imageRegistrationCertificateUrl = null;
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
                  const SizedBox(
                    height: 25,
                  ),
                  ImageContainer(
                      title: "Bảo hiểm xe",
                      image: imageCarInsurance != null ||
                          imageCarInsuranceUrl != null,
                      height: 250.0,
                      width: MediaQuery.of(context).size.width,
                      imageUnit8List: imageCarInsurance,
                      imageUrl: imageCarInsuranceUrl,
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
                                      imageCarInsurance = imgCamera;
                                      imageCarInsuranceUrl = null;
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
                                    imageCarInsurance = imgGallery;
                                    imageCarInsuranceUrl = null;
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
              if (widget.isEdit) {
                Get.to(() => PriceRentalScreen(
                      carModel: widget.car,
                      isEdit: true,
                      imageCarMain: widget.imageCarMain,
                      imageCarInside: widget.imageCarInside,
                      imageCarFront: widget.imageCarFront,
                      imageCarBack: widget.imageCarBack,
                      imageCarLeft: widget.imageCarLeft,
                      imageCarRight: widget.imageCarRight,
                      imageRegistrationCertificate:
                          imageRegistrationCertificate,
                      imageCarInsurance: imageCarInsurance,
                    ));
              } else if (widget.view) {
                Get.to(() => PriceRentalScreen(
                      carModel: widget.car,
                      view: true,
                    ));
              } else if (imageCarInsurance != null &&
                  imageRegistrationCertificate != null) {
                Get.to(() => PriceRentalScreen(
                      carModel: widget.car,
                      imageCarMain: widget.imageCarMain!,
                      imageCarInside: widget.imageCarInside!,
                      imageCarFront: widget.imageCarFront!,
                      imageCarBack: widget.imageCarBack!,
                      imageCarLeft: widget.imageCarLeft!,
                      imageCarRight: widget.imageCarRight!,
                      imageRegistrationCertificate:
                          imageRegistrationCertificate!,
                      imageCarInsurance: imageCarInsurance!,
                    ));
              } else {
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
