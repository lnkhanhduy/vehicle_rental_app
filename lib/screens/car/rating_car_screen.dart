import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/rental_controller.dart';
import 'package:vehicle_rental_app/utils/constants.dart';

class RatingCarScreen extends StatefulWidget {
  final String idRental;
  final String idUserRental;
  final String idCar;

  const RatingCarScreen(
      {super.key,
      required this.idRental,
      required this.idUserRental,
      required this.idCar});

  @override
  State<RatingCarScreen> createState() => _RatingCarScreenState();
}

class _RatingCarScreenState extends State<RatingCarScreen> {
  final review = TextEditingController();
  int star = 5;
  bool isWaiting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_outlined)),
        title: const Text(
          "Đánh giá thuê xe",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              constraints: const BoxConstraints.expand(),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Mức độ hài lòng của bạn",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  RatingBar.builder(
                    initialRating: 5,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        star = rating.toInt();
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: review,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Nhập nhận xét của bạn',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.1),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Constants.primaryColor,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                    ),
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (review.text.trim().isEmpty ||
                          (star <= 0 && star > 5)) {
                        Get.closeCurrentSnackbar();
                        Get.showSnackbar(GetSnackBar(
                          messageText: const Text(
                            "Vui lòng nhập nhận xét!",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Colors.red,
                          duration: const Duration(seconds: 10),
                          icon: const Icon(Icons.error, color: Colors.white),
                          onTap: (_) {
                            Get.closeCurrentSnackbar();
                          },
                        ));
                      } else {
                        setState(() {
                          isWaiting = true;
                        });
                        await RentalController.instance.ratingRental(
                            widget.idRental,
                            widget.idUserRental,
                            widget.idCar,
                            star,
                            review.text.trim());
                        setState(() {
                          isWaiting = false;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.primaryColor,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    child: isWaiting
                        ? const CircularProgressIndicator()
                        : const Text("Đánh giá"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
