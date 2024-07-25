import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/screens/register_car/info_rental_screen.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: (car.isApproved == true &&
                    (car.message == null || car.message!.isEmpty))
                ? Colors.green
                : (car.isApproved != true &&
                        car.message != null &&
                        car.message!.isNotEmpty)
                    ? Colors.redAccent
                    : Colors.grey,
          ),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              SizedBox(
                width: 80,
                height: 60,
                child: Stack(children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: car.imageCarMain != null
                          ? Image(
                              image: Image.network(
                                car.imageCarMain!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    "lib/assets/images/no_image.png",
                                    fit: BoxFit.cover,
                                  );
                                },
                              ).image,
                              width: 60,
                              height: 40,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              "lib/assets/images/no_image.png",
                              width: 60,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ]),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          car.carInfoModel,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Hãng xe: ${car.carCompany}',
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 4),
                    (car.isApproved == true &&
                            (car.message == null || car.message!.isEmpty))
                        ? Icon(Icons.check, color: Colors.green)
                        : (car.isApproved != true &&
                                car.message != null &&
                                car.message!.isNotEmpty)
                            ? Icon(Icons.close, color: Colors.red)
                            : Icon(Icons.warning_amber, color: Colors.grey),
                  ],
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
