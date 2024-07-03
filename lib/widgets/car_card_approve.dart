import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/screens/user_rental/info_rental_screen.dart';

class CarCardApprove extends StatelessWidget {
  final bool view;
  final bool isEdit;
  final CarModel car;

  const CarCardApprove(
      {super.key, required this.car, this.isEdit = false, this.view = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.to(() => InfoRentalScreen(
                car: car,
                isEdit: isEdit,
                view: view,
              ));
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: car.imageCarMain != null
                      ? Image(
                          image: Image.network(
                            car.imageCarMain!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                "lib/assets/images/no_car_image.png",
                                fit: BoxFit.cover,
                              );
                            },
                          ).image,
                          width: 60,
                          height: 40,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          "lib/assets/images/no_car_image.png",
                          width: 60,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        car.carInfoModel,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Hãng xe: ${car.carCompany}',
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      (car.isApproved == true &&
                              (car.message == null || car.message!.isEmpty))
                          ? const Text(
                              'Đã duyệt',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.green),
                            )
                          : (car.isApproved != true &&
                                  car.message != null &&
                                  car.message!.isNotEmpty)
                              ? const Text(
                                  'Từ chối',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.red),
                                )
                              : const Text(
                                  'Chưa duyệt',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.red),
                                ),
                      car.isApproved != true &&
                              car.message != null &&
                              car.message!.isNotEmpty
                          ? Text(
                              'Lý do: ${car.message!}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.red),
                            )
                          : Container(),
                    ],
                  ),
                )
              ],
            ),
          ]),
        ));
  }
}
