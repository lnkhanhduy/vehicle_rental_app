import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String? imageAvatar;
  final String? address;
  final String? imageLicenseFront;
  final String? imageLicenseBack;
  final String? imageIdCardFront;
  final String? imageIdCardBack;
  final bool? isVerified;
  final String? message;
  final bool isAdmin;
  final String? provider;
  final bool isRented;
  final int totalRental;
  final int star;
  final bool isPublic;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    this.imageAvatar,
    this.address,
    this.imageLicenseFront,
    this.imageLicenseBack,
    this.imageIdCardFront,
    this.imageIdCardBack,
    this.isVerified,
    this.message,
    required this.isAdmin,
    this.provider,
    this.isRented = false,
    this.totalRental = 0,
    this.star = 0,
    this.isPublic = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'imageAvatar': imageAvatar,
      'address': address,
      'imageLicenseFront': imageLicenseFront,
      'imageLicenseBack': imageLicenseBack,
      'imageIdCardFront': imageIdCardFront,
      'imageIdCardBack': imageIdCardBack,
      'isVerified': isVerified,
      'message': message,
      'isAdmin': isAdmin,
      'provider': provider,
      'isRented': isRented,
      'totalRental': totalRental,
      'star': star,
      'isPublic': isPublic,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return UserModel(
      id: snapshot.id,
      name: data['name'],
      email: data['email'],
      phone: data['phone'],
      password: '',
      imageAvatar: data['imageAvatar'],
      address: data['address'],
      imageLicenseFront: data['imageLicenseFront'],
      imageLicenseBack: data['imageLicenseBack'],
      imageIdCardFront: data['imageIdCardFront'],
      imageIdCardBack: data['imageIdCardBack'],
      isVerified: data['isVerified'],
      message: data['message'],
      isAdmin: data['isAdmin'],
      provider: data['provider'],
      isRented: data['isRented'],
      totalRental: data['totalRental'],
      star: data['star'],
      isPublic: data['isPublic'],
    );
  }
}
