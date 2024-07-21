import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/admin_controller.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/screens/flash_screen.dart';
import 'package:vehicle_rental_app/widgets/car_card_approve.dart';

class ApproveCarScreen extends StatefulWidget {
  const ApproveCarScreen({super.key});

  @override
  State<ApproveCarScreen> createState() => _ApproveCarScreenState();
}

class _ApproveCarScreenState extends State<ApproveCarScreen> {
  @override
  Widget build(BuildContext context) {
    Get.closeCurrentSnackbar();

    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text(
          "Xét duyệt xe",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                UserController.instance.logout();
              },
              icon: Icon(
                Icons.logout_outlined,
                color: Colors.red,
              ))
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<List<CarModel>?>(
        future: AdminController.instance.getCarApproveScreen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return FlashScreen();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Không có xe cần duyệt.'));
          } else {
            List<CarModel> carList = snapshot.data!;
            return Container(
              color: Colors.white,
              child: ListView.builder(
                itemCount: carList.length,
                itemBuilder: (context, index) {
                  CarModel car = carList[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                    child: CarCardApprove(
                      car: car,
                      view: true,
                    ),
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
