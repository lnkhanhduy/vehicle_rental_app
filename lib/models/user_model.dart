import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String? imageAvatar;
  final String? address;
  final String? typeLicense;
  final String? imageLicenseFront;
  final String? imageLicenseBack;
  final String? imageIdCardFront;
  final String? imageIdCardBack;
  final bool? isLicenseVerified;
  final bool? isIdCardVerified;
  final bool isAdmin;
  final String? provider;

  const UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    this.imageAvatar,
    this.address,
    this.typeLicense,
    this.imageLicenseFront,
    this.imageLicenseBack,
    this.imageIdCardFront,
    this.imageIdCardBack,
    this.isLicenseVerified,
    this.isIdCardVerified,
    required this.isAdmin,
    this.provider,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'imageAvatar': imageAvatar,
      'address': address,
      'typeLicense': typeLicense,
      'imageLicenseFront': imageLicenseFront,
      'imageLicenseBack': imageLicenseBack,
      'imageIdCardFront': imageIdCardFront,
      'imageIdCardBack': imageIdCardBack,
      'isLicenseVerified': isLicenseVerified,
      'isIdCardVerified': isIdCardVerified,
      'isAdmin': isAdmin,
      'provider': provider,
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
      typeLicense: data['typeLicense'],
      imageLicenseFront: data['imageLicenseFront'],
      imageLicenseBack: data['imageLicenseBack'],
      imageIdCardFront: data['imageIdCardFront'],
      imageIdCardBack: data['imageIdCardBack'],
      isLicenseVerified: data['isLicenseVerified'],
      isIdCardVerified: data['isIdCardVerified'],
      isAdmin: data['isAdmin'],
      provider: data['provider'],
    );
  }
}
