import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/admin_controller.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/screens/flash_screen.dart';
import 'package:vehicle_rental_app/screens/layout_screen.dart';
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
        leading: IconButton(
            onPressed: () => Get.to(() => const LayoutScreen(initialIndex: 3)),
            icon: const Icon(Icons.arrow_back)),
        title: const Text(
          "Xét duyệt xe",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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
            return ListView.builder(
              itemCount: carList.length,
              itemBuilder: (context, index) {
                CarModel car = carList[index];
                return Column(
                  children: [
                    CarCardApprove(
                      car: car,
                      view: true,
                    ),
                    const Divider(
                      height: 1,
                    )
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
