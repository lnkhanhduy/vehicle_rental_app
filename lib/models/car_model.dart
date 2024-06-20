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
    };
  }

  factory CarModel.fromJson(Map<String, dynamic> json, String id) {
    return CarModel(
      id: id,
      licensePlates: json['licensePlates'],
      carCompany: json['carCompany'],
      carInfoModel: json['carInfoModel'],
      yearManufacture: json['yearManufacture'],
      carSeat: json['carSeat'],
      transmission: json['transmission'],
      fuel: json['fuel'],
      addressRoad: json['addressRoad'],
      addressDistrict: json['addressDistrict'],
      addressCity: json['addressCity'],
      description: json['description'],
      map: json['map'],
      cctv: json['cctv'],
      sensor: json['sensor'],
      usb: json['usb'],
      tablet: json['tablet'],
      airBag: json['airBag'],
      bluetooth: json['bluetooth'],
      cameraBack: json['cameraBack'],
      tire: json['tire'],
      etc: json['etc'],
      imageCarMain: json['imageCarMain'],
      imageCarFront: json['imageCarFront'],
      imageCarBack: json['imageCarBack'],
      imageCarLeft: json['imageCarLeft'],
      imageCarRight: json['imageCarRight'],
      imageCarInside: json['imageCarInside'],
      imageRegistrationCertificate: json['imageRegistrationCertificate'],
      imageCarInsurance: json['imageCarInsurance'],
      price: json['price'],
      email: json['email'],
      isHidden: json['isHidden'],
      isApproved: json['isApproved'],
      message: json['message'],
    );
  }
}
