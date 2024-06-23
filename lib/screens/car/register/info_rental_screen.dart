import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/screens/car/register/image_rental_screen.dart';
import 'package:vehicle_rental_app/screens/layout_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';
import 'package:vehicle_rental_app/widgets/header_register_car.dart';

class InfoRentalScreen extends StatefulWidget {
  final CarModel? car;
  final bool view;
  final bool isEdit;

  const InfoRentalScreen(
      {super.key, this.car, this.view = false, this.isEdit = false});

  @override
  State<InfoRentalScreen> createState() => _InfoRentalScreenState();
}

class _InfoRentalScreenState extends State<InfoRentalScreen> {
  TextEditingController licensePlates = TextEditingController();
  TextEditingController carCompany = TextEditingController();
  TextEditingController carInfoModel = TextEditingController();
  TextEditingController addressRoad = TextEditingController();
  TextEditingController addressDistrict = TextEditingController();
  TextEditingController addressCity = TextEditingController();
  TextEditingController description = TextEditingController();

  late String selectedYear = '2024';
  late String selectedSeat = '4';
  late String selectedTransmission = 'automatic';
  late String selectedFuel = 'gasoline';
  late bool selectedMap = false;
  late bool selectedCctv = false;
  late bool selectedSensor = false;
  late bool selectedUsb = false;
  late bool selectedTablet = false;
  late bool selectedAirBag = false;
  late bool selectedBluetooth = false;
  late bool selectedCameraBack = false;
  late bool selectedTire = false;
  late bool selectedEtc = false;

  List<String> years = [
    '2024',
    '2023',
    '2022',
    '2021',
    '2020',
    '2019',
    '2018',
    '2017',
    '2016',
    '2015',
    '2014',
    '2013',
    '2012',
    '2011',
    '2010',
  ];

  List<String> seats = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
  ];

  @override
  void initState() {
    super.initState();

    if (widget.isEdit || widget.view) {
      licensePlates.text = widget.car?.licensePlates ?? '';
      carCompany.text = widget.car?.carCompany ?? '';
      carInfoModel.text = widget.car?.carInfoModel ?? '';
      addressRoad.text = widget.car?.addressRoad ?? '';
      addressDistrict.text = widget.car?.addressDistrict ?? '';
      addressCity.text = widget.car?.addressCity ?? '';
      description.text = widget.car?.description ?? '';
      selectedYear = widget.car?.yearManufacture ?? '2024';
      selectedSeat = widget.car?.carSeat ?? '4';
      selectedTransmission = widget.car?.transmission ?? 'automatic';
      selectedFuel = widget.car?.fuel ?? 'gasoline';
      selectedMap = widget.car?.map ?? false;
      selectedCctv = widget.car?.cctv ?? false;
      selectedSensor = widget.car?.sensor ?? false;
      selectedUsb = widget.car?.usb ?? false;
      selectedTablet = widget.car?.tablet ?? false;
      selectedAirBag = widget.car?.airBag ?? false;
      selectedBluetooth = widget.car?.bluetooth ?? false;
      selectedCameraBack = widget.car?.cameraBack ?? false;
      selectedTire = widget.car?.tire ?? false;
      selectedEtc = widget.car?.etc ?? false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.closeCurrentSnackbar();
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
          title: const Text(
            "Thông tin",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () => Get.to(() => const LayoutScreen(
                      initialIndex: 0,
                    )),
                icon: const Icon(
                  Icons.close,
                ))
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                constraints: const BoxConstraints.expand(),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const HeaderRegisterCar(
                        imageScreen: false,
                        paperScreen: false,
                        priceScreen: false),
                    const Text(
                      "Thông tin cơ bản",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Biển số xe ',
                                ),
                                TextSpan(
                                  text: '*',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextField(
                            readOnly: widget.view,
                            controller: licensePlates,
                            decoration: InputDecoration(
                              hintText: 'Nhập biển số xe',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Constants.primaryColor,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 12),
                            ),
                            style: const TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Hãng xe ',
                                ),
                                TextSpan(
                                  text: '*',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextField(
                            readOnly: widget.view,
                            controller: carCompany,
                            decoration: InputDecoration(
                              hintText: 'Nhập hãng xe',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Constants.primaryColor,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 12),
                            ),
                            style: const TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Mẫu xe ',
                                ),
                                TextSpan(
                                  text: '*',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextField(
                            readOnly: widget.view,
                            controller: carInfoModel,
                            decoration: InputDecoration(
                              hintText: 'Nhập mẫu xe',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Constants.primaryColor,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 12),
                            ),
                            style: const TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Năm sản xuất ',
                                    ),
                                    TextSpan(
                                      text: '*',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.42,
                                child: FormField<String>(
                                  builder: (FormFieldState<String> state) {
                                    return InputDecorator(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(0.1),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          borderSide: BorderSide(
                                            color: Constants.primaryColor,
                                          ),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12),
                                      ),
                                      isEmpty: selectedYear == '',
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: selectedYear,
                                          isDense: true,
                                          onChanged: (newValue) {
                                            setState(() {
                                              selectedYear = newValue!;
                                              state.didChange(newValue);
                                            });
                                          },
                                          items: years.map((String year) {
                                            return DropdownMenuItem<String>(
                                              value: year,
                                              child: Text(year),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Số ghế ',
                                    ),
                                    TextSpan(
                                      text: '*',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.42,
                                child: FormField<String>(
                                  builder: (FormFieldState<String> state) {
                                    return InputDecorator(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(0.1),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          borderSide: BorderSide(
                                            color: Constants.primaryColor,
                                          ),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12),
                                      ),
                                      isEmpty: selectedSeat == '',
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: selectedSeat,
                                          isDense: true,
                                          onChanged: (newValue) {
                                            setState(() {
                                              selectedSeat = newValue!;
                                              state.didChange(newValue);
                                            });
                                          },
                                          items: seats.map((String seat) {
                                            return DropdownMenuItem<String>(
                                              value: seat,
                                              child: Text(seat),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Truyền động ',
                                    ),
                                    TextSpan(
                                      text: '*',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.42,
                                child: FormField<String>(
                                  builder: (FormFieldState<String> state) {
                                    return InputDecorator(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(0.1),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          borderSide: BorderSide(
                                            color: Constants.primaryColor,
                                          ),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12),
                                      ),
                                      isEmpty: selectedTransmission == '',
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: selectedTransmission,
                                          isDense: true,
                                          onChanged: (newValue) {
                                            setState(() {
                                              selectedTransmission = newValue!;
                                              state.didChange(newValue);
                                            });
                                          },
                                          items: ['automatic', 'manual']
                                              .map((String transmission) {
                                            return DropdownMenuItem<String>(
                                              value: transmission,
                                              child: Text(
                                                  transmission == 'automatic'
                                                      ? 'Số tự động'
                                                      : 'Số sàn'),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Loại nhiên liệu ',
                                    ),
                                    TextSpan(
                                      text: '*',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.42,
                                child: FormField<String>(
                                  builder: (FormFieldState<String> state) {
                                    return InputDecorator(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(0.1),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          borderSide: BorderSide(
                                            color: Constants.primaryColor,
                                          ),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12),
                                      ),
                                      isEmpty: selectedFuel == '',
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: selectedFuel,
                                          isDense: true,
                                          onChanged: (newValue) {
                                            setState(() {
                                              selectedFuel = newValue!;
                                              state.didChange(newValue);
                                            });
                                          },
                                          items: [
                                            'gasoline',
                                            'diesel',
                                            'electric'
                                          ].map((String fuel) {
                                            return DropdownMenuItem<String>(
                                              value: fuel,
                                              child: Text(fuel == 'gasoline'
                                                  ? 'Xăng'
                                                  : fuel == 'diesel'
                                                      ? 'Dầu Diesel'
                                                      : 'Điện'),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      height: 1,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Thông tin bổ sung",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Địa chỉ xe ',
                                    ),
                                    TextSpan(
                                      text: '*',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 13,
                              ),
                              TextField(
                                readOnly: widget.view,
                                controller: addressRoad,
                                decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      color: Colors.black, fontSize: 14),
                                  labelText: 'Số nhà, tên đường',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.1),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      color: Constants.primaryColor,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                ),
                                style: const TextStyle(fontSize: 15),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextField(
                            readOnly: widget.view,
                            controller: addressDistrict,
                            decoration: InputDecoration(
                              labelStyle: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                              labelText: 'Quận/Huyện',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Constants.primaryColor,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 12),
                            ),
                            style: const TextStyle(fontSize: 15),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextField(
                            readOnly: widget.view,
                            controller: addressCity,
                            decoration: InputDecoration(
                              labelStyle: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                              labelText: 'Tỉnh/Thành phố',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Constants.primaryColor,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 12),
                            ),
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Mô tả"),
                          const SizedBox(
                            height: 15,
                          ),
                          TextField(
                            controller: description,
                            maxLines: 10,
                            decoration: InputDecoration(
                              labelStyle: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                              hintText: 'Mô tả về ngắn gọn xe',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Constants.primaryColor,
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(15),
                            ),
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text("Các tính năng trên xe"),
                    TextButton(
                        onPressed: () {
                          showModalSelectFeature(context);
                        },
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(0)),
                        child: Text(
                          'Chọn tính năng >',
                          style: TextStyle(color: Constants.primaryColor),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          color: Constants.primaryColor.withOpacity(0.05),
          child: SizedBox(
            child: ElevatedButton(
              onPressed: () {
                CarModel carModel = CarModel(
                  id: widget.car?.id,
                  licensePlates: licensePlates.text.trim(),
                  carCompany: carCompany.text.trim(),
                  carInfoModel: carInfoModel.text.trim(),
                  yearManufacture: selectedYear,
                  carSeat: selectedSeat,
                  transmission: selectedTransmission,
                  fuel: selectedFuel,
                  addressRoad: addressRoad.text.trim(),
                  addressDistrict: addressDistrict.text.trim(),
                  addressCity: addressCity.text.trim(),
                  description: description.text.trim(),
                  map: selectedMap,
                  cctv: selectedCctv,
                  sensor: selectedSensor,
                  usb: selectedUsb,
                  tablet: selectedTablet,
                  airBag: selectedAirBag,
                  bluetooth: selectedBluetooth,
                  cameraBack: selectedCameraBack,
                  tire: selectedTire,
                  etc: selectedEtc,
                  imageCarMain: widget.car?.imageCarMain,
                  imageCarInside: widget.car?.imageCarInside,
                  imageCarFront: widget.car?.imageCarFront,
                  imageCarBack: widget.car?.imageCarBack,
                  imageCarLeft: widget.car?.imageCarLeft,
                  imageCarRight: widget.car?.imageCarRight,
                  imageRegistrationCertificate:
                      widget.car?.imageRegistrationCertificate,
                  imageCarInsurance: widget.car?.imageCarInsurance,
                  price: widget.car?.price,
                  isHidden: widget.car?.isHidden,
                  isApproved: widget.car?.isApproved,
                );

                if (widget.view) {
                  Get.to(() => ImageRentalScreen(
                        car: widget.car!,
                        view: true,
                      ));
                } else if (widget.isEdit) {
                  Get.to(() => ImageRentalScreen(
                        car: carModel,
                        isEdit: true,
                      ));
                } else if (licensePlates.text.trim().isEmpty ||
                    carCompany.text.trim().isEmpty ||
                    carInfoModel.text.trim().isEmpty ||
                    addressRoad.text.trim().isEmpty ||
                    addressDistrict.text.trim().isEmpty ||
                    addressCity.text.trim().isEmpty) {
                  Get.closeCurrentSnackbar();
                  Get.showSnackbar(GetSnackBar(
                    messageText: const Text(
                      "Vui lòng nhập đầy đủ trường có dấu (*)",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 10),
                    icon: const Icon(Icons.error, color: Colors.white),
                    onTap: (_) {
                      Get.closeCurrentSnackbar();
                    },
                  ));
                } else {
                  Get.to(() => ImageRentalScreen(car: carModel));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Constants.primaryColor,
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              child: const Text(
                "Tiếp tục",
              ),
            ),
          ),
        ));
  }

  void showModalSelectFeature(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Chọn tính năng",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return Checkbox(
                                      value: selectedMap,
                                      activeColor: Colors.green,
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedMap = newValue!;
                                        });
                                      },
                                    );
                                  },
                                ),
                                const Text("Bản đồ")
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return Checkbox(
                                      value: selectedCctv,
                                      activeColor: Colors.green,
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedCctv = newValue!;
                                        });
                                      },
                                    );
                                  },
                                ),
                                const Text("Camera hành trình")
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return Checkbox(
                                      value: selectedSensor,
                                      activeColor: Colors.green,
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedSensor = newValue!;
                                        });
                                      },
                                    );
                                  },
                                ),
                                const Text("Cảm biến va chạm")
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return Checkbox(
                                      value: selectedUsb,
                                      activeColor: Colors.green,
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedUsb = newValue!;
                                        });
                                      },
                                    );
                                  },
                                ),
                                const Text("Khe cắm USB")
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return Checkbox(
                                      value: selectedTablet,
                                      activeColor: Colors.green,
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedTablet = newValue!;
                                        });
                                      },
                                    );
                                  },
                                ),
                                const Text("Màn hình")
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return Checkbox(
                                      value: selectedAirBag,
                                      activeColor: Colors.green,
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedAirBag = newValue!;
                                        });
                                      },
                                    );
                                  },
                                ),
                                const Text("Túi khí an toàn")
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return Checkbox(
                                      value: selectedBluetooth,
                                      activeColor: Colors.green,
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedBluetooth = newValue!;
                                        });
                                      },
                                    );
                                  },
                                ),
                                const Text("Bluetooth")
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return Checkbox(
                                      value: selectedCameraBack,
                                      activeColor: Colors.green,
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedCameraBack = newValue!;
                                        });
                                      },
                                    );
                                  },
                                ),
                                const Text("Camera lùi")
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return Checkbox(
                                      value: selectedTire,
                                      activeColor: Colors.green,
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedTire = newValue!;
                                        });
                                      },
                                    );
                                  },
                                ),
                                const Text("Lốp dự phòng")
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return Checkbox(
                                      value: selectedEtc,
                                      activeColor: Colors.green,
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedEtc = newValue!;
                                        });
                                      },
                                    );
                                  },
                                ),
                                const Text("ETC")
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                Positioned(
                    top: -15,
                    right: -15,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ))
              ],
            ));
      },
    );
  }
}
