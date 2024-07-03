import 'package:cloud_firestore/cloud_firestore.dart';

class RentalModel {
  final String? id;
  final String? email;
  final String? idOwner;
  final String idCar;
  final String fromDate;
  final String toDate;
  final String status;
  final String? message;
  final String? review;
  final int? star;
  final String? reviewDate;

  const RentalModel({
    this.id,
    this.email,
    this.idOwner,
    required this.idCar,
    required this.fromDate,
    required this.toDate,
    this.status = 'waiting',
    this.message,
    this.review,
    this.star,
    this.reviewDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'idOwner': idOwner,
      'idCar': idCar,
      'fromDate': fromDate,
      'toDate': toDate,
      'status': status,
      'message': message,
      'review': review,
      'star': star,
      'reviewDate': reviewDate
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
        status: data['status'],
        message: data['message'],
        review: data['review'],
        star: data['star'],
        reviewDate: data['reviewDate'],
      );
    }
  }
}
