import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/models/rental_car_model.dart';
import 'package:vehicle_rental_app/screens/loading_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';
import 'package:vehicle_rental_app/widgets/car_card_rental.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final userController = Get.put(UserController());

  late Future futureGet = userController.getHistory();
  late bool isRental = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text(
          "Lịch sử",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: futureGet,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreen();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Object> carList = snapshot.data!;

            return Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: 36,
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                isRental = !isRental;
                                futureGet = userController.getHistory();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isRental
                                  ? Constants.primaryColor
                                  : Colors.grey.shade100,
                              foregroundColor:
                                  isRental ? Colors.white : Colors.black,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    bottomLeft: Radius.circular(4)),
                              ),
                            ),
                            child: const Text(
                              "Thuê",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: 36,
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                isRental = !isRental;
                                futureGet = userController.getHistoryRental();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: !isRental
                                  ? Constants.primaryColor
                                  : Colors.grey.shade100,
                              foregroundColor:
                                  !isRental ? Colors.white : Colors.black,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(4),
                                    bottomRight: Radius.circular(4)),
                              ),
                            ),
                            child: const Text(
                              "Cho thuê",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  (!snapshot.hasData || snapshot.data!.isEmpty)
                      ? Center(child: Text("Chưa có dữ liệu!"))
                      : Expanded(
                          child: ListView.builder(
                            itemCount: carList.length,
                            itemBuilder: (context, index) {
                              RentalCarModel? rentalCarModel =
                                  carList[index] as RentalCarModel?;

                              if (isRental) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 15),
                                  child: CarCardRental(
                                    rentalCarModel: rentalCarModel!,
                                    isHistory: true,
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 15),
                                  child: CarCardRental(
                                    rentalCarModel: rentalCarModel!,
                                    isHistory: true,
                                    isOwner: true,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
