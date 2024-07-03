import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/models/rental_car_model.dart';
import 'package:vehicle_rental_app/screens/layout_screen.dart';
import 'package:vehicle_rental_app/widgets/car_card_rental.dart';

class HistoryRentalScreen extends StatefulWidget {
  const HistoryRentalScreen({super.key});

  @override
  State<HistoryRentalScreen> createState() => _HistoryRentalScreenState();
}

class _HistoryRentalScreenState extends State<HistoryRentalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.to(() => const LayoutScreen(initialIndex: 3)),
            icon: const Icon(Icons.arrow_back)),
        title: const Text(
          "Lịch sử cho thuê xe",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<RentalCarModel>?>(
        future: UserController.instance.getHistoryRental(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Bạn chưa từng cho thuê xe'));
          } else {
            List<RentalCarModel> rentalCarList = snapshot.data!;
            return ListView.builder(
              itemCount: rentalCarList.length,
              itemBuilder: (context, index) {
                RentalCarModel rentalCarModel = rentalCarList[index];
                return Column(
                  children: [
                    CarCardRental(
                      rentalCarModel: rentalCarModel,
                      isHistory: true,
                      isOwner: true,
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
