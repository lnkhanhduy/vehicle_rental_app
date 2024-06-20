import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/car_controller.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/screens/car/approve_screen.dart';
import 'package:vehicle_rental_app/screens/layout_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';

class PriceRentalScreen extends StatefulWidget {
  final CarModel carModel;
  final bool view;
  final bool isEdit;
  final Uint8List? imageCarMain;
  final Uint8List? imageCarInside;
  final Uint8List? imageCarFront;
  final Uint8List? imageCarBack;
  final Uint8List? imageCarLeft;
  final Uint8List? imageCarRight;
  final Uint8List? imageRegistrationCertificate;
  final Uint8List? imageCarInsurance;

  const PriceRentalScreen(
      {super.key,
      required this.carModel,
      this.view = false,
      this.isEdit = false,
      this.imageCarMain,
      this.imageCarInside,
      this.imageCarFront,
      this.imageCarBack,
      this.imageCarLeft,
      this.imageCarRight,
      this.imageRegistrationCertificate,
      this.imageCarInsurance});

  @override
  State<PriceRentalScreen> createState() => _PriceRentalScreenState();
}

class _PriceRentalScreenState extends State<PriceRentalScreen> {
  final controller = Get.put(CarController());
  TextEditingController price = TextEditingController();
  TextEditingController message = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.isEdit || widget.view) {
      price.text = widget.carModel.price!;
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
            "Giá cho thuê",
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    color: Constants.primaryColor),
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
                                  color: Constants.primaryColor,
                                ),
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(
                                    "lib/assets/icons/dollar.png",
                                    color: Colors.white,
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
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Giá cho thuê /ngày',
                          ),
                          TextSpan(
                            text: '*',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: price,
                      decoration: InputDecoration(
                        hintText: 'Nhập giá cho thuê /ngày',
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
                            vertical: 0, horizontal: 12),
                      ),
                      style: const TextStyle(fontSize: 15),
                    ),
                    (widget.view && widget.carModel.isApproved == false)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Text("Nhập lý do không duyệt (Nếu chọn từ chối)"),
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
                              SizedBox(
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
                                            duration:
                                                const Duration(seconds: 10),
                                            icon: const Icon(Icons.error,
                                                color: Colors.white),
                                            onTap: (_) {
                                              Get.closeCurrentSnackbar();
                                            },
                                          ));
                                        } else {
                                          await controller.cancelCar(
                                              widget.carModel.id!,
                                              message.text.trim());
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
                                      child: Text("Từ chối"),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        await controller
                                            .approveCar(widget.carModel.id!);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Constants.primaryColor,
                                        foregroundColor: Colors.white,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                        ),
                                      ),
                                      child: Text("Duyệt"),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        : Container()
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: ((widget.view == false && widget.isEdit == true) ||
                (widget.view == false && widget.isEdit == false) ||
                (widget.view == true && widget.carModel.isApproved == true))
            ? Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                color: Constants.primaryColor.withOpacity(0.05),
                child: SizedBox(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (widget.isEdit == true &&
                          widget.carModel.isApproved == true) {
                        _showConfirmationDialog();
                      } else if (widget.isEdit == true) {
                        await controller.registerCar(
                            true,
                            widget.carModel,
                            widget.imageCarMain!,
                            widget.imageCarInside!,
                            widget.imageCarFront!,
                            widget.imageCarBack!,
                            widget.imageCarLeft!,
                            widget.imageCarRight!,
                            widget.imageRegistrationCertificate!,
                            widget.imageCarInsurance!,
                            price.text.trim());
                      } else if (widget.view && widget.carModel.isApproved!) {
                        Get.to(() => ApproveScreen());
                      } else if (price.text.trim().isEmpty) {
                        Get.closeCurrentSnackbar();
                        Get.showSnackbar(GetSnackBar(
                          messageText: const Text(
                            "Vui lòng nhập giá cho thuê xe!",
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
                        await controller.registerCar(
                            false,
                            widget.carModel,
                            widget.imageCarMain!,
                            widget.imageCarInside!,
                            widget.imageCarFront!,
                            widget.imageCarBack!,
                            widget.imageCarLeft!,
                            widget.imageCarRight!,
                            widget.imageRegistrationCertificate!,
                            widget.imageCarInsurance!,
                            price.text.trim());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.primaryColor,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    child: Text(
                      widget.isEdit
                          ? "Cập nhật"
                          : (widget.view && widget.carModel.isApproved!)
                              ? "Đóng"
                              : "Đăng ký",
                    ),
                  ),
                ),
              )
            : null);
  }

  Future<void> _showConfirmationDialog() async {
    await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận cập nhật'),
          content: const Text(
              'Xe của bạn xác minh.\nNếu cập nhật bạn sẽ phải chờ xác minh lại.\nBạn có chắc muốn cập nhật không?'),
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
                await controller.registerCar(
                    widget.isEdit,
                    widget.carModel,
                    widget.imageCarMain!,
                    widget.imageCarInside!,
                    widget.imageCarFront!,
                    widget.imageCarBack!,
                    widget.imageCarLeft!,
                    widget.imageCarRight!,
                    widget.imageRegistrationCertificate!,
                    widget.imageCarInsurance!,
                    price.text.trim());
              },
            ),
          ],
        );
      },
    );
  }
}
