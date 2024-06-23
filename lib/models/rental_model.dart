import 'package:cloud_firestore/cloud_firestore.dart';

class RentalModel {
  final String? id;
  final String? email;
  final String? idOwner;
  final String idCar;
  final String fromDate;
  final String toDate;
  final bool isApproved;
  final String? message;
  final String? review;
  final String? star;

  const RentalModel({
    this.id,
    this.email,
    this.idOwner,
    required this.idCar,
    required this.fromDate,
    required this.toDate,
    this.isApproved = false,
    this.message,
    this.review,
    this.star,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'idOwner': idOwner,
      'idCar': idCar,
      'fromDate': fromDate,
      'toDate': toDate,
      'isApproved': isApproved,
      'message': message,
      'review': review,
      'star': star
    };
  }

  factory RentalModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    {
      return RentalModel(
        id: snapshot.id,
        email: data['email'],
        idOwner: data['idOwner'],
        idCar: data['idCar'],
        fromDate: data['fromDate'],
        toDate: data['toDate'],
        isApproved: data['isApproved'],
        message: data['message'],
        review: data['review'],
        star: data['star'],
      );
    }
  }
}
