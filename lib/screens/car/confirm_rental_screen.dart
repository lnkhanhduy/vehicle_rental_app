import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/rental_controller.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/models/rental_model.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/screens/user/profile_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';
import 'package:vehicle_rental_app/utils/utils.dart';

class ConfirmRentalScreen extends StatefulWidget {
  final CarModel car;
  final UserModel userModel;
  final DateTime fromDate;
  final DateTime toDate;
  final int days;

  const ConfirmRentalScreen(
      {super.key,
      required this.car,
      required this.userModel,
      required this.fromDate,
      required this.toDate,
      required this.days});

  @override
  State<ConfirmRentalScreen> createState() => _ConfirmRentalScreenState();
}

class _ConfirmRentalScreenState extends State<ConfirmRentalScreen> {
  final message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
          title: const Text(
            "Xác nhận đặt xe",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.network(
                            widget.car.imageCarMain!,
                            fit: BoxFit.cover,
                            width: 60,
                            height: 40,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                "lib/assets/images/no_car_image.png",
                                fit: BoxFit.cover,
                                width: 60,
                                height: 40,
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.car.carInfoModel,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 13,
                                  height: 13,
                                  child: Image.asset(
                                    "lib/assets/icons/star.png",
                                  ),
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                const Text("5.0"),
                                SizedBox(
                                  width: 17,
                                  height: 17,
                                  child: Image.asset(
                                    "lib/assets/icons/dot_full.png",
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(
                                    "lib/assets/icons/road_trip.png",
                                    color: Constants.primaryColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                const Text("2 chuyến"),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      height: 1,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Chi tiết thuê xe",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  Icons.calendar_month_outlined,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  "Nhận xe",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              BoardDateFormat('HH:mm dd/MM/yyyy')
                                  .format(widget.fromDate),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  Icons.calendar_month_outlined,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text("Trả xe",
                                    style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              BoardDateFormat('HH:mm dd/MM/yyyy')
                                  .format(widget.toDate),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text("Số ngày: ${widget.days} ngày"),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 18,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text("Nhận xe tại",
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                        '${widget.car.addressRoad}, ${widget.car.addressDistrict}, ${widget.car.addressCity}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      children: [
                        Icon(
                          Icons.credit_card_outlined,
                          size: 18,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text("Phương thức thanh toán",
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Thanh toán khi nhận xe",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    const Divider(height: 1),
                    const SizedBox(height: 20),
                    const Text(
                      "Chủ xe",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          color: Colors.white,
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => const ProfileScreen());
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 70,
                                height: 70,
                                child: widget.userModel.imageAvatar != null &&
                                        widget.userModel.imageAvatar!.isNotEmpty
                                    ? Image.network(
                                        widget.userModel.imageAvatar!,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            "lib/assets/images/no_image.png",
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      )
                                    : Image.asset(
                                        "lib/assets/images/no_avatar.png"),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.userModel.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 13,
                                        height: 13,
                                        child: Image.asset(
                                          "lib/assets/icons/star.png",
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      const Text("5.0"),
                                      SizedBox(
                                        width: 17,
                                        height: 17,
                                        child: Image.asset(
                                          "lib/assets/icons/dot_full.png",
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: Image.asset(
                                          "lib/assets/icons/road_trip.png",
                                          color: Constants.primaryColor,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      const Text("2 chuyến"),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      height: 1,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Nhập lời nhắn cho chủ xe",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                          )),
                      child: TextField(
                        controller: message,
                        maxLines: 4,
                        decoration: const InputDecoration.collapsed(
                          hintText: "Nhập lời nhắn cho chủ xe",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 15),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      height: 1,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.5),
                            )),
                        child: Column(children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Tổng tiền",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Text(
                                  '${Utils.formatNumber(int.parse(widget.car.price!) * widget.days)} VND',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ]),
                        ]))
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
              onPressed: () async {
                RentalModel rentalModel = RentalModel(
                  idCar: widget.car.id!,
                  fromDate: widget.fromDate.toString(),
                  toDate: widget.toDate.toString(),
                  message: message.text.trim(),
                  idOwner: widget.userModel.email,
                );

                await RentalController.instance.sendRequestRental(rentalModel);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Constants.primaryColor,
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              child: const Text(
                "Gửi yêu cầu thuê xe",
              ),
            ),
          ),
        ));
  }
}
