import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/screens/car/register/info_rental_screen.dart';

class CarCardApprove extends StatelessWidget {
  final CarModel car;

  const CarCardApprove({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.to(() => InfoRentalScreen(
                car: car,
                view: true,
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
                          image: NetworkImage(car.imageCarMain!),
                          width: 60,
                          height: 40,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          "lib/assets/images/no_avatar.png",
                          width: 60,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
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
                    car.isApproved == true
                        ? const Text(
                            'Đã duyệt',
                            style: TextStyle(fontSize: 14, color: Colors.green),
                          )
                        : const Text(
                            'Chưa duyệt',
                            style: TextStyle(fontSize: 14, color: Colors.red),
                          ),
                  ],
                )
              ],
            ),
          ]),
        ));
  }
}
