import 'package:vehicle_rental_app/models/rental_model.dart';
import 'package:vehicle_rental_app/models/user_model.dart';

class RentalUserModel {
  final RentalModel rentalModel;
  final UserModel userModel;

  RentalUserModel({required this.rentalModel, required this.userModel});
}
