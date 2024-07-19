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
        leading: Container(),
        centerTitle: true,
        backgroundColor: Colors.white,
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

            return Container(
              padding: const EdgeInsets.fromLTRB(30, 5, 30, 0),
              color: Colors.white,
              child: ListView.builder(
                itemCount: carList.length,
                itemBuilder: (context, index) {
                  CarModel car = carList[index];
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: CarCard(car: car),
                      ),
                    ],
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
