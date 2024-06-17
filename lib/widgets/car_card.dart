import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/screens/car/car_details_screen.dart';
import 'package:vehicle_rental_app/screens/home_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';

class CarCard extends StatelessWidget {
  final Car car;

  const CarCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.to(() => CarDetailsScreen(car: car));
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    height: 240,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: Image.asset(
                          "lib/assets/images/no_car_image.png",
                        ).image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // child: PageView.builder(
                    //   itemCount: 10,
                    //   itemBuilder: (context, index) {
                    //     return ClipRRect(
                    //       borderRadius: BorderRadius.circular(10),
                    //       child: Image.asset(
                    //         "lib/assets/images/no_car_image.png",
                    //         fit: BoxFit.cover,
                    //         width: double.infinity,
                    //       ),
                    //     );
                    //   },
                    // ),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(4),
                      style: IconButton.styleFrom(
                          backgroundColor: Colors.grey[500]),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      car.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 17,
                          color: Colors.grey[500],
                        ),
                        const SizedBox(width: 3),
                        Text(
                          "Quận 6 HCM",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Divider(),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 13,
                              height: 13,
                              child: Image.asset(
                                "lib/assets/icons/star.png",
                              ),
                            ),
                            SizedBox(
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
                        Row(children: [
                          Text("633K",
                              style: TextStyle(
                                  color: Constants.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                          const Text(" / ngày")
                        ])
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
