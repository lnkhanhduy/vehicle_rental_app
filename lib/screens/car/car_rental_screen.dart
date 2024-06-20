import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/car_controller.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/screens/profile/profile_screen.dart';
import 'package:vehicle_rental_app/widgets/car_card_approve.dart';

class CarRentalScreen extends StatefulWidget {
  const CarRentalScreen({super.key});

  @override
  State<CarRentalScreen> createState() => _CarRentalScreenState();
}

class _CarRentalScreenState extends State<CarRentalScreen> {
  final CarController controller = Get.put(CarController());

  @override
  Widget build(BuildContext context) {
    Get.closeCurrentSnackbar();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.to(() => ProfileScreen()),
            icon: const Icon(Icons.arrow_back)),
        title: const Text(
          "Xe đã đăng ký cho thuê",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<CarModel>?>(
        future: controller.getCarApprove(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data found'));
          } else {
            List<CarModel> carList = snapshot.data!;
            return ListView.builder(
              itemCount: carList.length,
              itemBuilder: (context, index) {
                CarModel car = carList[index];
                return Column(
                  children: [
                    CarCardApprove(car: car),
                    Divider(
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
