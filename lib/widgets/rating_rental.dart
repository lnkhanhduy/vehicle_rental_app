import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/screens/profile/profile_screen.dart';

class RatingRental extends StatelessWidget {
  const RatingRental({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.asset(
                            "lib/assets/images/no_avatar.png",
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Lê Nguyễn Khánh Duy",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                            Text(
                              "16/06/2024",
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ],
                    ),
                    const Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Text(
                          "good",
                          style: TextStyle(fontSize: 13),
                        ))
                  ],
                ),
                Positioned(
                    top: 7,
                    right: 8,
                    child: Row(
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
                        const Text(
                          "5.0",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ))
              ],
            )));
  }
}
