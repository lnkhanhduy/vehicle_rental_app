import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/screens/car/register/price_rental_screen.dart';
import 'package:vehicle_rental_app/screens/layout_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';
import 'package:vehicle_rental_app/utils/utils.dart';

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
              onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
          title: const Text(
            "Giấy tờ",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () => Get.to(() => const LayoutScreen(
                      initialIndex: 0,
                    )),
                icon: const Icon(
                  Icons.close,
                ))
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                constraints: const BoxConstraints.expand(),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(children: [
                            Container(
                                padding: const EdgeInsets.all(11),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Constants.primaryColor,
                                ),
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(
                                    "lib/assets/icons/info.png",
                                    color: Colors.white,
                                  ),
                                )),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              "Thông tin",
                              style: TextStyle(fontSize: 13),
                            )
                          ]),
                          Column(
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(5),
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Image.asset(
                                      "lib/assets/icons/dash.png",
                                      color: Colors.grey,
                                    ),
                                  )),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                "",
                                style: TextStyle(fontSize: 13),
                              )
                            ],
                          ),
                          Column(children: [
                            Container(
                                padding: const EdgeInsets.all(11),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Constants.primaryColor,
                                ),
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(
                                    "lib/assets/icons/image.png",
                                    color: Colors.white,
                                  ),
                                )),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              "Hình ảnh",
                              style: TextStyle(fontSize: 13),
                            )
                          ]),
                          Column(
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(5),
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Image.asset(
                                      "lib/assets/icons/dash.png",
                                      color: Colors.grey,
                                    ),
                                  )),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                "",
                                style: TextStyle(fontSize: 13),
                              )
                            ],
                          ),
                          Column(children: [
                            Container(
                                padding: const EdgeInsets.all(11),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Constants.primaryColor,
                                ),
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(
                                    "lib/assets/icons/paper.png",
                                    color: Colors.white,
                                  ),
                                )),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              "Giấy tờ",
                              style: TextStyle(fontSize: 13),
                            )
                          ]),
                          Column(
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(5),
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Image.asset(
                                      "lib/assets/icons/dash.png",
                                      color: Colors.grey,
                                    ),
                                  )),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                "",
                                style: TextStyle(fontSize: 13),
                              )
                            ],
                          ),
                          Column(children: [
                            Container(
                                padding: const EdgeInsets.all(11),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(0.3))),
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(
                                    "lib/assets/icons/dollar.png",
                                    color: Constants.primaryColor,
                                  ),
                                )),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              "Giá  thuê",
                              style: TextStyle(fontSize: 13),
                            )
                          ]),
                        ],
                      ),
                    ),
                    const Text(
                      "Giấy đăng ký xe",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () async {
                        Uint8List? imgRegister =
                            await Utils.pickImage(ImageSource.gallery);
                        if (imgRegister != null) {
                          setState(() {
                            imageRegistrationCertificate = imgRegister;
                            imageRegistrationCertificateUrl = null;
                          });
                        }
                      },
                      child: imageCarInsurance != null ||
                              imageRegistrationCertificateUrl != null
                          ? Container(
                              height: 250,
                              decoration: BoxDecoration(
                                image:
                                    (imageRegistrationCertificateUrl != null ||
                                            imageRegistrationCertificateUrl!
                                                .isNotEmpty)
                                        ? DecorationImage(
                                            image: NetworkImage(
                                                imageRegistrationCertificateUrl!),
                                            fit: BoxFit.cover,
                                          )
                                        : DecorationImage(
                                            image: MemoryImage(
                                                imageRegistrationCertificate!),
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
                              height: 250,
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
                    const Text(
                      "Bảo hiểm xe",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () async {
                        Uint8List? imgInsurance =
                            await Utils.pickImage(ImageSource.gallery);
                        if (imgInsurance != null) {
                          setState(() {
                            imageCarInsurance = imgInsurance;
                            imageCarInsuranceUrl = null;
                          });
                        }
                      },
                      child: imageCarInsurance != null ||
                              imageCarInsuranceUrl != null
                          ? Container(
                              height: 250,
                              decoration: BoxDecoration(
                                image: (imageCarInsuranceUrl != null ||
                                        imageCarInsuranceUrl!.isNotEmpty)
                                    ? DecorationImage(
                                        image:
                                            NetworkImage(imageCarInsuranceUrl!),
                                        fit: BoxFit.cover,
                                      )
                                    : DecorationImage(
                                        image: MemoryImage(imageCarInsurance!),
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
                              height: 250,
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
        ));
  }
}
