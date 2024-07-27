import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/admin_controller.dart';
import 'package:vehicle_rental_app/controllers/car_controller.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/screens/layout_admin_screen.dart';
import 'package:vehicle_rental_app/screens/layout_screen.dart';
import 'package:vehicle_rental_app/screens/loading_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';
import 'package:vehicle_rental_app/utils/utils.dart';
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
  final carController = Get.put(CarController());
  final adminController = Get.put(AdminController());

  TextEditingController price = TextEditingController();
  TextEditingController message = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    if (widget.isEdit || widget.view) {
      price.text = widget.carModel.price!;
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
            "Giá cho thuê",
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
              ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: isLoading
                  ? LoadingScreen()
                  : Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
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
                                  text: 'Giá cho thuê /ngày ',
                                ),
                                TextSpan(
                                  text: '*',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextField(
                            readOnly: widget.view,
                            controller: price,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              hintText: 'Nhập giá cho thuê /ngày',
                              hintStyle: TextStyle(
                                color: Color(0xff888888),
                                fontSize: 15,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
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
                                    const SizedBox(height: 20),
                                    const Text(
                                        "Nhập lý do không duyệt (Nếu chọn từ chối)"),
                                    const SizedBox(height: 5),
                                    TextField(
                                      controller: message,
                                      maxLines: 4,
                                      decoration: InputDecoration(
                                        hintText: 'Nhập lý do không duyệt',
                                        hintStyle: TextStyle(
                                          color: Color(0xff888888),
                                          fontSize: 15,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(0.1),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                            color: Constants.primaryColor,
                                          ),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
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
                                                    await adminController
                                                        .cancelCar(
                                                            widget.carModel.id!,
                                                            message.text
                                                                .trim());
                                                if (result) {
                                                  Utils.showSnackBar(
                                                      "Từ chối thành công.",
                                                      Colors.green,
                                                      Icons.check);
                                                  Get.to(() =>
                                                      const LayoutAdminScreen(
                                                          initialIndex: 0));
                                                }
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              foregroundColor: Colors.white,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
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
                                              bool result =
                                                  await adminController
                                                      .approveCar(
                                                          widget.carModel.id!);
                                              if (result) {
                                                Utils.showSnackBar(
                                                    "Duyệt thành công.",
                                                    Colors.green,
                                                    Icons.check);
                                                Get.to(() =>
                                                    const LayoutAdminScreen(
                                                        initialIndex: 0));
                                              }
                                              setState(() {
                                                isLoading = false;
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Constants.primaryColor,
                                              foregroundColor: Colors.white,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
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
                        showConfirmationDialog();
                      } else if (widget.isEdit == true &&
                          widget.carModel.isApproved != true) {
                        setState(() {
                          isLoading = true;
                        });
                        await carController.updateCar(
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
                        setState(() {
                          isLoading = false;
                        });
                      } else if ((widget.view && widget.carModel.isApproved!) ||
                          (widget.view &&
                              widget.carModel.isApproved != true &&
                              widget.carModel.message != null &&
                              widget.carModel.message!.isNotEmpty)) {
                        Get.to(() => const LayoutAdminScreen(initialIndex: 0));
                      } else if (price.text.trim().isEmpty) {
                        Utils.showSnackBar("Vui lòng nhập giá cho thuê xe.",
                            Colors.red, Icons.error);
                      } else {
                        setState(() {
                          isLoading = true;
                        });
                        await carController.registerCar(
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
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.primaryColor,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
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

  Future<void> showConfirmationDialog() async {
    await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Xác nhận cập nhật'),
          content: const Text(
              'Xe của bạn đã được duyệt.\nNếu cập nhật bạn sẽ phải chờ duyệt lại.\nBạn có chắc muốn cập nhật không?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Đóng', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child:
                  const Text('Cập nhật', style: TextStyle(color: Colors.blue)),
              onPressed: () async {
                Navigator.of(context).pop(true);
                if (widget.carModel.isRented) {
                  Utils.showSnackBar(
                      "Xe đang được cho thuê.", Colors.red, Icons.error);
                } else {
                  setState(() {
                    isLoading = true;
                  });
                  await carController.updateCar(
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
