import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/models/rental_user_model.dart';
import 'package:vehicle_rental_app/screens/profile/profile_display_screen.dart';

class RatingRental extends StatefulWidget {
  final RentalUserModel rentalUserModel;

  const RatingRental({super.key, required this.rentalUserModel});

  @override
  State<RatingRental> createState() => _RatingRentalState();
}

class _RatingRentalState extends State<RatingRental> {
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
              Get.to(
                () => ProfileDisplayScreen(
                    userModel: widget.rentalUserModel.userModel),
              );
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
                          child: (widget.rentalUserModel.userModel
                                          .imageAvatar !=
                                      null &&
                                  widget.rentalUserModel.userModel
                                          .imageAvatar !=
                                      "")
                              ? Image(
                                  image: Image.network(
                                  widget.rentalUserModel.userModel.imageAvatar!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      "lib/assets/images/no_avatar.png",
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ).image)
                              : Image.asset(
                                  "lib/assets/images/no_avatar.png",
                                ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.rentalUserModel.userModel.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                            Text(
                              BoardDateFormat('dd/MM/yyyy').format(
                                  DateTime.parse(widget.rentalUserModel
                                      .rentalModel.reviewDate!)),
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Text(
                          widget.rentalUserModel.rentalModel.review ??
                              "Không có nhận xét.",
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
