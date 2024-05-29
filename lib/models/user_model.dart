import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String? imageAvatar;
  final String? address;
  final String? imageLicense;
  final String? imageIdCard;
  final bool? isLicenseVerified;
  final bool? isIdCardVerified;
  final bool isAdmin;

  const UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    this.imageAvatar,
    this.address,
    this.imageLicense,
    this.imageIdCard,
    this.isLicenseVerified,
    this.isIdCardVerified,
    required this.isAdmin,
  });

  toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'imageAvatar': imageAvatar,
      'address': address,
      'imageLicense': imageLicense,
      'imageIdCard': imageIdCard,
      'isLicenseVerified': isLicenseVerified,
      'isIdCardVerified': isIdCardVerified,
      'isAdmin': isAdmin,
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
      password: data['password'],
      imageAvatar: data['imageAvatar'],
      address: data['address'],
      imageLicense: data['imageLicense'],
      imageIdCard: data['imageIdCard'],
      isLicenseVerified: data['isLicenseVerified'],
      isIdCardVerified: data['isIdCardVerified'],
      isAdmin: data['isAdmin'],
    );
  }
}
