import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/models/rental_model.dart';

class RentalCarModel {
  final RentalModel rentalModel;
  final CarModel carModel;

  RentalCarModel({required this.rentalModel, required this.carModel});
}
