import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/models/rental_car_model.dart';
import 'package:vehicle_rental_app/screens/layout_screen.dart';
import 'package:vehicle_rental_app/screens/loading_screen.dart';
import 'package:vehicle_rental_app/widgets/car_card_rental.dart';

class RequestRentalCarScreen extends StatefulWidget {
  const RequestRentalCarScreen({super.key});

  @override
  State<RequestRentalCarScreen> createState() => _RequestRentalCarScreenState();
}

class _RequestRentalCarScreenState extends State<RequestRentalCarScreen> {
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.to(() => const LayoutScreen(initialIndex: 4)),
            icon: const Icon(Icons.arrow_back_ios_outlined)),
        title: const Text(
          "Yêu cầu thuê xe",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<List<RentalCarModel>?>(
        future: userController.getRequestCarRentalScreen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreen();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Container(
              color: Colors.white,
              child: Center(child: Text('Bạn chưa có yêu cầu thuê xe')),
            );
          } else {
            List<RentalCarModel> rentalCarList = snapshot.data!;
            return Container(
              color: Colors.white,
              child: ListView.builder(
                itemCount: rentalCarList.length,
                itemBuilder: (context, index) {
                  RentalCarModel rentalCarModel = rentalCarList[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                    child: CarCardRental(
                        rentalCarModel: rentalCarModel, isOwner: true),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
