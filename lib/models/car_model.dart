import 'package:cloud_firestore/cloud_firestore.dart';

class CarModel {
  final String? id;
  final String licensePlates;
  final String carCompany;
  final String carInfoModel;
  final String yearManufacture;
  final String carSeat;
  final String transmission;
  final String fuel;
  final String addressRoad;
  final String addressDistrict;
  final String addressCity;
  final String? description;
  final bool? map;
  final bool? cctv;
  final bool? sensor;
  final bool? usb;
  final bool? tablet;
  final bool? airBag;
  final bool? bluetooth;
  final bool? cameraBack;
  final bool? tire;
  final bool? etc;
  final String? imageCarMain;
  final String? imageCarFront;
  final String? imageCarBack;
  final String? imageCarLeft;
  final String? imageCarRight;
  final String? imageCarInside;
  final String? imageRegistrationCertificate;
  final String? imageCarInsurance;
  final String? price;
  final String? email;
  final bool? isHidden;
  final bool? isApproved;
  final String? message;
  final int totalRental;
  final int star;
  final bool? isFavorite;
  final bool isRented;

  const CarModel({
    this.id,
    required this.licensePlates,
    required this.carCompany,
    required this.carInfoModel,
    required this.yearManufacture,
    required this.carSeat,
    required this.transmission,
    required this.fuel,
    required this.addressRoad,
    required this.addressDistrict,
    required this.addressCity,
    this.description,
    this.map,
    this.cctv,
    this.sensor,
    this.usb,
    this.tablet,
    this.airBag,
    this.bluetooth,
    this.cameraBack,
    this.tire,
    this.etc,
    this.imageCarMain,
    this.imageCarFront,
    this.imageCarBack,
    this.imageCarLeft,
    this.imageCarRight,
    this.imageCarInside,
    this.imageRegistrationCertificate,
    this.imageCarInsurance,
    this.price,
    this.email,
    this.isHidden = false,
    this.isApproved = false,
    this.message,
    this.totalRental = 0,
    this.star = 0,
    this.isFavorite,
    this.isRented = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'licensePlates': licensePlates,
      'carCompany': carCompany,
      'carInfoModel': carInfoModel,
      'yearManufacture': yearManufacture,
      'carSeat': carSeat,
      'transmission': transmission,
      'fuel': fuel,
      'addressRoad': addressRoad,
      'addressDistrict': addressDistrict,
      'addressCity': addressCity,
      'description': description,
      'map': map,
      'cctv': cctv,
      'sensor': sensor,
      'usb': usb,
      'tablet': tablet,
      'airBag': airBag,
      'bluetooth': bluetooth,
      'cameraBack': cameraBack,
      'tire': tire,
      'etc': etc,
      'imageCarMain': imageCarMain,
      'imageCarFront': imageCarFront,
      'imageCarBack': imageCarBack,
      'imageCarLeft': imageCarLeft,
      'imageCarRight': imageCarRight,
      'imageCarInside': imageCarInside,
      'imageRegistrationCertificate': imageRegistrationCertificate,
      'imageCarInsurance': imageCarInsurance,
      'price': price,
      'email': email,
      'isHidden': isHidden,
      'isApproved': isApproved,
      'message': message,
      'totalRental': totalRental,
      'star': star,
      'isFavorite': isFavorite,
      'isRented': isRented,
    };
  }

  factory CarModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot,
      {bool? isFavorite}) {
    final data = snapshot.data()!;
    {
      return CarModel(
        id: snapshot.id,
        licensePlates: data['licensePlates'],
        carCompany: data['carCompany'],
        carInfoModel: data['carInfoModel'],
        yearManufacture: data['yearManufacture'],
        carSeat: data['carSeat'],
        transmission: data['transmission'],
        fuel: data['fuel'],
        addressRoad: data['addressRoad'],
        addressDistrict: data['addressDistrict'],
        addressCity: data['addressCity'],
        description: data['description'],
        map: data['map'],
        cctv: data['cctv'],
        sensor: data['sensor'],
        usb: data['usb'],
        tablet: data['tablet'],
        airBag: data['airBag'],
        bluetooth: data['bluetooth'],
        cameraBack: data['cameraBack'],
        tire: data['tire'],
        etc: data['etc'],
        imageCarMain: data['imageCarMain'],
        imageCarFront: data['imageCarFront'],
        imageCarBack: data['imageCarBack'],
        imageCarLeft: data['imageCarLeft'],
        imageCarRight: data['imageCarRight'],
        imageCarInside: data['imageCarInside'],
        imageRegistrationCertificate: data['imageRegistrationCertificate'],
        imageCarInsurance: data['imageCarInsurance'],
        price: data['price'],
        email: data['email'],
        isHidden: data['isHidden'],
        isApproved: data['isApproved'],
        message: data['message'],
        totalRental: data['totalRental'],
        star: data['star'],
        isFavorite: isFavorite ?? false,
        isRented: data['isRented'],
      );
    }
  }
}
