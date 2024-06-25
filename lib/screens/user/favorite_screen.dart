import 'package:flutter/material.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/widgets/car_card.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Xe yêu thích",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<CarModel>?>(
        future: UserController.instance.getFavorite(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('Bạn chưa thêm xe nào vào yêu thích.'));
          } else {
            List<CarModel> carList = snapshot.data!;

            return ListView.builder(
              itemCount: carList.length,
              itemBuilder: (context, index) {
                CarModel car = carList[index];
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: CarCard(car: car),
                    ),
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
