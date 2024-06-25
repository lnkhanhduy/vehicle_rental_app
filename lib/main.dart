import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/admin_controller.dart';
import 'package:vehicle_rental_app/controllers/car_controller.dart';
import 'package:vehicle_rental_app/controllers/rental_controller.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/firebase_options.dart';
import 'package:vehicle_rental_app/screens/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Get.put(UserController());
  Get.put(AdminController());
  Get.put(CarController());
  Get.put(RentalController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
