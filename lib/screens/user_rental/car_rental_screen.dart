import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/screens/layout_screen.dart';
import 'package:vehicle_rental_app/widgets/car_card_approve.dart';

class CarRentalScreen extends StatefulWidget {
  const CarRentalScreen({super.key});

  @override
  State<CarRentalScreen> createState() => _CarRentalScreenState();
}

class _CarRentalScreenState extends State<CarRentalScreen> {
  @override
  Widget build(BuildContext context) {
    Get.closeCurrentSnackbar();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.to(() => const LayoutScreen(initialIndex: 3)),
            icon: const Icon(Icons.arrow_back)),
        title: const Text(
          "Xe đã đăng ký cho thuê",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<CarModel>?>(
        future: UserController.instance.getCarRentalScreen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Bạn chưa đăng ký cho thuê xe'));
          } else {
            List<CarModel> carList = snapshot.data!;
            return ListView.builder(
              itemCount: carList.length,
              itemBuilder: (context, index) {
                CarModel car = carList[index];
                return Column(
                  children: [
                    CarCardApprove(car: car, isEdit: true),
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
