import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/screens/car/car_details_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';
import 'package:vehicle_rental_app/utils/utils.dart';

class CarCard extends StatefulWidget {
  final CarModel car;

  const CarCard({super.key, required this.car});

  @override
  State<CarCard> createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  final userController = Get.put(UserController());

  bool isFavoriteCar = false;

  @override
  void initState() {
    super.initState();
    isFavoriteCar = widget.car.isFavorite ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => CarDetailsScreen(car: widget.car));
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
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: widget.car.imageCarMain != null
                          ? Image.network(
                              widget.car.imageCarMain!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  "lib/assets/images/no_image.png",
                                  fit: BoxFit.cover,
                                );
                              },
                            )
                          : Image.asset(
                              "lib/assets/images/no_image.png",
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: IconButton(
                      onPressed: () async {
                        Get.closeCurrentSnackbar();
                        await userController.addFavorite(widget.car.id!);

                        setState(() {
                          isFavoriteCar = !isFavoriteCar;
                        });
                      },
                      icon: Icon(
                        isFavoriteCar ? Icons.favorite : Icons.favorite_border,
                        color: isFavoriteCar
                            ? Constants.primaryColor
                            : Colors.white,
                      ),
                      padding: const EdgeInsets.all(4),
                      style: IconButton.styleFrom(
                          backgroundColor: Colors.grey.withOpacity(0.5)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.car.carInfoModel,
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
                        widget.car.address,
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
                          const SizedBox(
                            width: 3,
                          ),
                          Text(widget.car.star != 0 &&
                                  widget.car.totalRental != 0
                              ? (widget.car.star / widget.car.totalRental)
                                  .toStringAsFixed(1)
                              : "0"),
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
                          Text('${widget.car.totalRental} chuyến'),
                        ],
                      ),
                      Row(children: [
                        Text(Utils.formatNumber(int.parse(widget.car.price!)),
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
      ),
    );
  }
}
