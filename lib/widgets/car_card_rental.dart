import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/models/rental_car_model.dart';
import 'package:vehicle_rental_app/screens/car/car_details_request_rental_screen.dart';

class CarCardRental extends StatelessWidget {
  final RentalCarModel rentalCarModel;
  final bool isOwner;
  final bool isHistory;

  const CarCardRental(
      {super.key,
      required this.rentalCarModel,
      this.isOwner = false,
      this.isHistory = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.to(
            () => CarDetailsRequestRentalScreen(
                rentalCarModel: rentalCarModel,
                isOwner: isOwner,
                isHistory: isHistory),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                SizedBox(
                  width: 80,
                  height: 50,
                  child: Stack(children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: rentalCarModel.carModel.imageCarMain != null
                            ? Image(
                                image: Image.network(
                                  rentalCarModel.carModel.imageCarMain!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      "lib/assets/images/no_image.png",
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ).image,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                "lib/assets/images/no_image.png",
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rentalCarModel.carModel.carInfoModel,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Ngày thuê: ${BoardDateFormat('HH:mm dd/MM/yyyy').format(DateTime.parse(rentalCarModel.rentalModel.fromDate))}',
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Ngày trả: ${BoardDateFormat('HH:mm dd/MM/yyyy').format(DateTime.parse(rentalCarModel.rentalModel.toDate))}',
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      if (isHistory == true) const SizedBox(height: 7),
                      if (isHistory == true &&
                          rentalCarModel.rentalModel.status == "approved" &&
                          DateTime.parse(rentalCarModel.rentalModel.fromDate)
                              .isAfter(DateTime.now()) &&
                          DateTime.parse(rentalCarModel.rentalModel.toDate)
                              .isAfter(DateTime.now()))
                        const Text(
                          'Chờ nhận xe',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      if (isHistory == true &&
                          rentalCarModel.rentalModel.status == "approved" &&
                          DateTime.parse(rentalCarModel.rentalModel.fromDate)
                              .isBefore(DateTime.now()) &&
                          DateTime.parse(rentalCarModel.rentalModel.toDate)
                              .isAfter(DateTime.now()))
                        const Text(
                          'Đang thuê',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      if (isHistory == true &&
                          rentalCarModel.rentalModel.status == "paid")
                        const Text(
                          'Đã trả xe',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      if (isHistory == true &&
                          rentalCarModel.rentalModel.status == "approved" &&
                          DateTime.parse(rentalCarModel.rentalModel.fromDate)
                              .isBefore(DateTime.now()) &&
                          DateTime.parse(rentalCarModel.rentalModel.toDate)
                              .isBefore(DateTime.now()))
                        const Text(
                          'Chờ đánh giá',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      if (isHistory == true &&
                              rentalCarModel.rentalModel.status == "waiting" &&
                              (DateTime.parse(
                                          rentalCarModel.rentalModel.fromDate)
                                      .isBefore(DateTime.now()) ||
                                  DateTime.parse(
                                          rentalCarModel.rentalModel.toDate)
                                      .isBefore(DateTime.now())) ||
                          rentalCarModel.rentalModel.status == "rejected")
                        const Text(
                          'Từ chối',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      if (isHistory == true &&
                          rentalCarModel.rentalModel.status == "waiting" &&
                          DateTime.parse(rentalCarModel.rentalModel.fromDate)
                              .isAfter(DateTime.now()) &&
                          DateTime.parse(rentalCarModel.rentalModel.toDate)
                              .isAfter(DateTime.now()))
                        const Text(
                          'Chờ phản hồi',
                          style: TextStyle(
                            color: Colors.amber,
                          ),
                        ),
                      if (isHistory == true &&
                          rentalCarModel.rentalModel.status == "canceled")
                        const Text(
                          'Đã hủy',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ]),
        ));
  }
}
