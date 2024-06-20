import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/screens/car/register/paper_rental_screen.dart';
import 'package:vehicle_rental_app/screens/layout_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';
import 'package:vehicle_rental_app/utils/utils.dart';

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
    print(imageFrontUrl);
  }

  @override
  Widget build(BuildContext context) {
    Get.closeCurrentSnackbar();
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
          title: const Text(
            "Hình ảnh",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () =>
                    Get.to(() => const LayoutScreen(initialIndex: 0)),
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
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.3),
                                    )),
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(
                                    "lib/assets/icons/paper.png",
                                    color: Constants.primaryColor,
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
                      "Ảnh đại diện",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () async {
                        Uint8List? imgMain =
                            await Utils.pickImage(ImageSource.gallery);
                        if (imgMain != null) {
                          setState(() {
                            imageMain = imgMain;
                            imageMainUrl = null;
                          });
                        }
                      },
                      child: imageMain != null || imageMainUrl != null
                          ? Container(
                              height: 250,
                              decoration: BoxDecoration(
                                image: (imageMainUrl != null ||
                                        imageMainUrl!.isNotEmpty)
                                    ? DecorationImage(
                                        image: NetworkImage(imageMainUrl!),
                                        fit: BoxFit.cover,
                                      )
                                    : DecorationImage(
                                        image: MemoryImage(imageMain!),
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
                                  child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Image.asset(
                                  "lib/assets/icons/car_front.png",
                                ),
                              )),
                            ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Ảnh bên trong xe",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () async {
                        Uint8List? imgInside =
                            await Utils.pickImage(ImageSource.gallery);
                        if (imgInside != null) {
                          setState(() {
                            imageInside = imgInside;
                            imageInsideUrl = null;
                          });
                        }
                      },
                      child: imageInside != null || imageInsideUrl != null
                          ? Container(
                              height: 250,
                              decoration: BoxDecoration(
                                image: (imageMainUrl != null ||
                                        imageInsideUrl!.isNotEmpty)
                                    ? DecorationImage(
                                        image: NetworkImage(imageInsideUrl!),
                                        fit: BoxFit.cover,
                                      )
                                    : DecorationImage(
                                        image: MemoryImage(imageInside!),
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
                                  child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Image.asset(
                                  "lib/assets/icons/car_front.png",
                                ),
                              )),
                            ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(children: [
                            const Text(
                              "Ảnh trước",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () async {
                                Uint8List? imgFront =
                                    await Utils.pickImage(ImageSource.gallery);
                                if (imgFront != null) {
                                  setState(() {
                                    imageFront = imgFront;
                                    imageFrontUrl = null;
                                  });
                                }
                              },
                              child: imageFront != null || imageFrontUrl != null
                                  ? Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.42,
                                      height: 130,
                                      decoration: BoxDecoration(
                                        image: (imageFrontUrl != null ||
                                                imageFrontUrl!.isNotEmpty)
                                            ? DecorationImage(
                                                image: NetworkImage(
                                                    imageFrontUrl!),
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
                                      width: MediaQuery.of(context).size.width *
                                          0.42,
                                      height: 130,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                            color: Colors.grey[400]!),
                                      ),
                                      child: Center(
                                          child: SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: Image.asset(
                                          "lib/assets/icons/car_front.png",
                                        ),
                                      )),
                                    ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            const Text(
                              "Ảnh trái",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () async {
                                Uint8List? imgLeft =
                                    await Utils.pickImage(ImageSource.gallery);
                                if (imgLeft != null) {
                                  setState(() {
                                    imageLeft = imgLeft;
                                    imageLeftUrl = null;
                                  });
                                }
                              },
                              child: imageLeft != null || imageLeftUrl != null
                                  ? Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.42,
                                      height: 130,
                                      decoration: BoxDecoration(
                                        image: (imageLeftUrl != null ||
                                                imageLeftUrl!.isNotEmpty)
                                            ? DecorationImage(
                                                image:
                                                    NetworkImage(imageLeftUrl!),
                                                fit: BoxFit.cover,
                                              )
                                            : DecorationImage(
                                                image: MemoryImage(imageLeft!),
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
                                      width: MediaQuery.of(context).size.width *
                                          0.42,
                                      height: 130,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                            color: Colors.grey[400]!),
                                      ),
                                      child: Center(
                                          child: SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: Image.asset(
                                          "lib/assets/icons/car_left.png",
                                        ),
                                      )),
                                    ),
                            ),
                          ]),
                          Column(
                            children: [
                              const Text(
                                "Ảnh sau",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () async {
                                  Uint8List? imgBack = await Utils.pickImage(
                                      ImageSource.gallery);
                                  if (imgBack != null) {
                                    setState(() {
                                      imageBack = imgBack;
                                      imageBackUrl = null;
                                    });
                                  }
                                },
                                child: imageBack != null || imageBackUrl != null
                                    ? Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.42,
                                        height: 130,
                                        decoration: BoxDecoration(
                                          image: (imageBackUrl != null ||
                                                  imageBackUrl!.isNotEmpty)
                                              ? DecorationImage(
                                                  image: NetworkImage(
                                                      imageBackUrl!),
                                                  fit: BoxFit.cover,
                                                )
                                              : DecorationImage(
                                                  image:
                                                      MemoryImage(imageBack!),
                                                  fit: BoxFit.cover,
                                                ),
                                          borderRadius:
                                              BorderRadius.circular(16),
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.42,
                                        height: 130,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          border: Border.all(
                                              color: Colors.grey[400]!),
                                        ),
                                        child: Center(
                                            child: SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: Image.asset(
                                            "lib/assets/icons/car_back.png",
                                          ),
                                        )),
                                      ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "Ảnh phải",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () async {
                                  Uint8List? imgRight = await Utils.pickImage(
                                      ImageSource.gallery);
                                  if (imgRight != null) {
                                    setState(() {
                                      imageRight = imgRight;
                                      imageRightUrl = null;
                                    });
                                  }
                                },
                                child: imageRight != null ||
                                        imageRightUrl != null
                                    ? Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.42,
                                        height: 130,
                                        decoration: BoxDecoration(
                                          image: (imageRightUrl != null ||
                                                  imageRightUrl!.isNotEmpty)
                                              ? DecorationImage(
                                                  image: NetworkImage(
                                                      imageRightUrl!),
                                                  fit: BoxFit.cover,
                                                )
                                              : DecorationImage(
                                                  image:
                                                      MemoryImage(imageRight!),
                                                  fit: BoxFit.cover,
                                                ),
                                          borderRadius:
                                              BorderRadius.circular(16),
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.42,
                                        height: 130,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          border: Border.all(
                                              color: Colors.grey[400]!),
                                        ),
                                        child: Center(
                                            child: SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: Image.asset(
                                            "lib/assets/icons/car_right.png",
                                          ),
                                        )),
                                      ),
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
                        imageCarMain: imageMain!,
                        imageCarInside: imageInside!,
                        imageCarFront: imageFront!,
                        imageCarBack: imageBack!,
                        imageCarLeft: imageLeft!,
                        imageCarRight: imageRight!,
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
        ));
  }
}
