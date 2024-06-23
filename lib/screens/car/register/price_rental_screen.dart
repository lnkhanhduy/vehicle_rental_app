import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/car_controller.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/screens/car/approve_car_screen.dart';
import 'package:vehicle_rental_app/screens/layout_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';
import 'package:vehicle_rental_app/widgets/header_register_car.dart';

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
                    const HeaderRegisterCar(
                        imageScreen: true,
                        paperScreen: true,
                        priceScreen: true),
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
                      readOnly: widget.view,
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
                    (widget.view &&
                            widget.carModel.isApproved != true &&
                            (widget.carModel.message == null ||
                                widget.carModel.message!.isEmpty))
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                  "Nhập lý do không duyệt (Nếu chọn từ chối)"),
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
                                            duration:
                                                const Duration(seconds: 10),
                                            icon: const Icon(Icons.error,
                                                color: Colors.white),
                                            onTap: (_) {
                                              Get.closeCurrentSnackbar();
                                            },
                                          ));
                                        } else {
                                          await CarController.instance
                                              .cancelCar(widget.carModel.id!,
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
                                      child: const Text("Từ chối"),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        await CarController.instance
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
                                      child: const Text("Duyệt"),
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
                (widget.view == true && widget.carModel.isApproved == true) ||
                (widget.view &&
                    widget.carModel.isApproved != true &&
                    widget.carModel.message != null &&
                    widget.carModel.message!.isNotEmpty))
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
                      } else if (widget.isEdit == true &&
                          widget.carModel.isApproved != true) {
                        await CarController.instance.updateCar(
                            widget.carModel,
                            widget.imageCarMain,
                            widget.imageCarInside,
                            widget.imageCarFront,
                            widget.imageCarBack,
                            widget.imageCarLeft,
                            widget.imageCarRight,
                            widget.imageRegistrationCertificate,
                            widget.imageCarInsurance,
                            price.text.trim());
                      } else if ((widget.view && widget.carModel.isApproved!) ||
                          (widget.view &&
                              widget.carModel.isApproved != true &&
                              widget.carModel.message != null &&
                              widget.carModel.message!.isNotEmpty)) {
                        Get.to(() => const ApproveCarScreen());
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
                        await CarController.instance.registerCar(
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
                          : (widget.view && widget.carModel.isApproved! ||
                                  (widget.view &&
                                      widget.carModel.isApproved != true &&
                                      widget.carModel.message != null &&
                                      widget.carModel.message!.isNotEmpty))
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
                await CarController.instance.updateCar(
                    widget.carModel,
                    widget.imageCarMain,
                    widget.imageCarInside,
                    widget.imageCarFront,
                    widget.imageCarBack,
                    widget.imageCarLeft,
                    widget.imageCarRight,
                    widget.imageRegistrationCertificate,
                    widget.imageCarInsurance,
                    price.text.trim());
              },
            ),
          ],
        );
      },
    );
  }
}
