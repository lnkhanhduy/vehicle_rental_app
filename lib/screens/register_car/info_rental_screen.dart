import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/car_controller.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/screens/loading_screen.dart';
import 'package:vehicle_rental_app/screens/register_car/image_rental_screen.dart';
import 'package:vehicle_rental_app/screens/user_rental/car_rental_screen.dart';
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
  final carController = Get.put(CarController());

  TextEditingController licensePlates = TextEditingController();
  TextEditingController carInfoModel = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController addressRoad = TextEditingController();

  Map<String, dynamic> locations = {};
  List<String> provinces = [];
  List<String> districts = [];
  List<String> wards = [];
  String? selectedProvince;
  String? selectedDistrict;
  String? selectedWard;

  late String selectedCarCompany = 'Audi';
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
  late bool isHidden = false;

  bool isLoading = false;

  List<String> companyCars = [
    'Audi',
    'BMW',
    'Cadillac',
    'Ford',
    'Honda',
    'Hyundai',
    'Lexus',
    'Mazda',
    'Mercedes-Benz',
    'Mitsubishi',
    'Nissan',
    'Porsche',
    'Tesla',
    'Toyota',
    'VinFast',
  ];

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
    loadInitialData().then((_) {
      if (widget.car?.address != null) {
        parseInitialAddress(widget.car!.address);
      }
    });

    if (widget.isEdit || widget.view) {
      isHidden = widget.car?.isHidden ?? false;
      licensePlates.text = widget.car?.licensePlates ?? '';
      selectedCarCompany = widget.car?.carCompany ?? 'Audi';
      carInfoModel.text = widget.car?.carInfoModel ?? '';
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

  Future<void> loadInitialData() async {
    await loadLocations();
  }

  Future<void> loadLocations() async {
    final String response =
        await rootBundle.loadString('lib/assets/address/locations.json');
    final data = await json.decode(response);
    setState(() {
      locations = data;
      provinces = locations.keys.toList();
    });
  }

  void onProvinceSelected(String? province) {
    if (province != null) {
      setState(() {
        selectedProvince = province;
        districts = (locations[province]['quan-huyen'] as Map<String, dynamic>)
            .keys
            .toList();
        selectedDistrict = null; // Reset district and ward
        selectedWard = null;
        wards = [];
      });
    }
  }

  void onDistrictSelected(String? district) {
    if (district != null && selectedProvince != null) {
      setState(() {
        selectedDistrict = district;
        wards = (locations[selectedProvince]!['quan-huyen'][district]
                ['xa-phuong'] as Map<String, dynamic>)
            .keys
            .toList();
        selectedWard = null; // Reset ward
      });
    }
  }

  void onWardSelected(String? ward) {
    setState(() {
      selectedWard = ward;
    });
  }

  Future<void> parseInitialAddress(String address) async {
    final parts = address.split(', ');

    if (parts.length >= 4) {
      final wardName = parts[1];
      final districtName = parts[2];
      final provinceName = parts[3];

      final provinceCode = await locations.keys.firstWhere(
        (key) => locations[key]['name_with_type'].contains(provinceName),
        orElse: () => '',
      );

      if (provinceCode.isNotEmpty) {
        selectedProvince = provinceCode;

        final districtsData =
            locations[selectedProvince]['quan-huyen'] as Map<String, dynamic>;
        districts = districtsData.keys
            .where((key) =>
                districtsData[key]['name_with_type'].contains(districtName))
            .toList();
        if (districts.isNotEmpty) {
          selectedDistrict = districts.first;
          final wardsData = districtsData[selectedDistrict]['xa-phuong']
              as Map<String, dynamic>;
          wards = wardsData.keys
              .where(
                  (key) => wardsData[key]['name_with_type'].contains(wardName))
              .toList();
          if (wards.isNotEmpty) {
            selectedWard = wards.first;
          }
        }
        setState(() {
          addressRoad.text = parts[0];
          selectedProvince = provinceCode;
          selectedDistrict = districts.isNotEmpty ? districts.first : null;
          selectedWard = wards.isNotEmpty ? wards.first : null;
        });
      }
    }
  }

  String buildCompleteAddress() {
    final provinceName = selectedProvince != null
        ? locations[selectedProvince]!['name_with_type']
        : '';
    final districtName = selectedDistrict != null
        ? locations[selectedProvince]!['quan-huyen'][selectedDistrict]
            ['name_with_type']
        : '';
    final wardName = selectedWard != null
        ? locations[selectedProvince]!['quan-huyen'][selectedDistrict]
            ['xa-phuong'][selectedWard]['name_with_type']
        : '';
    final completeAddress = [
      addressRoad.text.trim(),
      wardName,
      districtName,
      provinceName,
    ].where((element) => element.isNotEmpty).join(', ');

    return completeAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_outlined)),
        backgroundColor: Colors.white,
        title: const Text(
          "Thông tin",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          if (widget.view)
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text(
                isHidden ? "ẨN" : "HIỆN",
                style: const TextStyle(color: Colors.black54, fontSize: 17),
              ),
            ),
          if (widget.isEdit)
            TextButton(
              onPressed: () async {
                await CarController.instance
                    .changeStatusCar(widget.car!.id!, !isHidden);
                setState(() {
                  isHidden = !isHidden;
                });
              },
              child: Text(
                isHidden ? "ẨN" : "HIỆN",
                style: const TextStyle(color: Colors.black54, fontSize: 17),
              ),
            ),
          if (widget.isEdit)
            IconButton(
              onPressed: () {
                showConfirmationDialog();
              },
              icon:
                  const Icon(Icons.delete_forever_outlined, color: Colors.red),
            ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: isLoading
                ? const LoadingScreen()
                : Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
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
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
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
                              const SizedBox(height: 5),
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
                              const SizedBox(height: 5),
                              SizedBox(
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
                                      isEmpty: selectedCarCompany == '',
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: selectedCarCompany,
                                          isDense: true,
                                          onChanged: (newValue) {
                                            setState(() {
                                              selectedCarCompany = newValue!;
                                              state.didChange(newValue);
                                            });
                                          },
                                          items:
                                              companyCars.map((String company) {
                                            return DropdownMenuItem<String>(
                                              value: company,
                                              child: Text(company),
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
                                    width: MediaQuery.of(context).size.width *
                                        0.42,
                                    child: FormField<String>(
                                      builder: (FormFieldState<String> state) {
                                        return InputDecorator(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.1),
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
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.42,
                                    child: FormField<String>(
                                      builder: (FormFieldState<String> state) {
                                        return InputDecorator(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.1),
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
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.42,
                                    child: FormField<String>(
                                      builder: (FormFieldState<String> state) {
                                        return InputDecorator(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.1),
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
                                                  selectedTransmission =
                                                      newValue!;
                                                  state.didChange(newValue);
                                                });
                                              },
                                              items: ['automatic', 'manual']
                                                  .map((String transmission) {
                                                return DropdownMenuItem<String>(
                                                  value: transmission,
                                                  child: Text(transmission ==
                                                          'automatic'
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
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.42,
                                    child: FormField<String>(
                                      builder: (FormFieldState<String> state) {
                                        return InputDecorator(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.1),
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
                        const SizedBox(height: 10),
                        const Divider(height: 1),
                        const SizedBox(height: 15),
                        const Text(
                          "Thông tin bổ sung",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
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
                                  const SizedBox(height: 10),
                                  Column(
                                    children: [
                                      DropdownButton<String>(
                                        value: selectedProvince,
                                        hint: const Text('Chọn Tỉnh/Thành Phố'),
                                        isExpanded: true,
                                        items: provinces.map((String key) {
                                          return DropdownMenuItem<String>(
                                            value: key,
                                            child: Text(locations[key]
                                                ['name_with_type']),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedProvince = newValue;
                                            final districtsData =
                                                locations[selectedProvince]
                                                        ['quan-huyen']
                                                    as Map<String, dynamic>;
                                            districts =
                                                districtsData.keys.toList();
                                            selectedDistrict =
                                                null; // Reset district and ward
                                            selectedWard = null;
                                            wards = [];
                                          });
                                        },
                                      ),
                                      DropdownButton<String>(
                                        value: selectedDistrict,
                                        hint: const Text('Chọn Quận/Huyện'),
                                        isExpanded: true,
                                        items: districts.map((String key) {
                                          return DropdownMenuItem<String>(
                                            value: key,
                                            child: Text(
                                                locations[selectedProvince]
                                                        ['quan-huyen'][key]
                                                    ['name_with_type']),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedDistrict = newValue;
                                            final wardsData =
                                                locations[selectedProvince]
                                                                ['quan-huyen']
                                                            [selectedDistrict]
                                                        ['xa-phuong']
                                                    as Map<String, dynamic>;
                                            wards = wardsData.keys.toList();
                                            selectedWard = null; // Reset ward
                                          });
                                        },
                                      ),
                                      DropdownButton<String>(
                                        value: selectedWard,
                                        hint: const Text('Chọn Xã/Phường'),
                                        isExpanded: true,
                                        items: wards.map((String key) {
                                          return DropdownMenuItem<String>(
                                            value: key,
                                            child: Text(
                                                locations[selectedProvince]
                                                                ['quan-huyen']
                                                            [selectedDistrict]
                                                        ['xa-phuong'][key]
                                                    ['name_with_type']),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedWard = newValue;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  TextField(
                                    readOnly: widget.view,
                                    controller: addressRoad,
                                    decoration: InputDecoration(
                                      labelStyle: const TextStyle(
                                          color: Colors.black, fontSize: 15),
                                      labelText: 'Số nhà/tên đường',
                                    ),
                                    style: const TextStyle(fontSize: 15),
                                  )
                                ],
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
                              const SizedBox(height: 15),
                              TextField(
                                readOnly: widget.view,
                                controller: description,
                                maxLines: 10,
                                decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      color: Colors.black, fontSize: 14),
                                  hintText:
                                      widget.view && description.text == ''
                                          ? 'Không có mô tả'
                                          : 'Mô tả về ngắn gọn xe',
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
                        const SizedBox(height: 12),
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
                          ),
                        ),
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
                carCompany: selectedCarCompany,
                carInfoModel: carInfoModel.text.trim(),
                yearManufacture: selectedYear,
                carSeat: selectedSeat,
                transmission: selectedTransmission,
                fuel: selectedFuel,
                address: buildCompleteAddress(),
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
                isRented: widget.car!.isRented,
                email: widget.car?.email,
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
                  carInfoModel.text.trim().isEmpty ||
                  selectedProvince == null ||
                  selectedDistrict == null ||
                  selectedWard == null ||
                  selectedProvince == null ||
                  selectedDistrict == null ||
                  selectedWard == null ||
                  addressRoad.text.trim().isEmpty) {
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
      ),
    );
  }

  void showModalSelectFeature(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Chọn tính năng",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> showConfirmationDialog() async {
    await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận xóa xe'),
          content: const Text('Bạn có chắc muốn xóa xe không?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Xóa'),
              onPressed: () async {
                Navigator.of(context).pop(true);
                if (widget.car!.isRented) {
                  Get.closeCurrentSnackbar();
                  Get.showSnackbar(GetSnackBar(
                    messageText: const Text(
                      "Xe đang được cho thuê!",
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
                  setState(() {
                    isLoading = true;
                  });
                  bool result =
                      await CarController.instance.deleteCar(widget.car!);
                  if (result) {
                    Get.closeCurrentSnackbar();
                    Get.showSnackbar(GetSnackBar(
                      messageText: const Text(
                        "Xóa xe thành công!",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 10),
                      icon: const Icon(Icons.check, color: Colors.white),
                      onTap: (_) {
                        Get.closeCurrentSnackbar();
                      },
                    ));
                    Get.offAll(() => const CarRentalScreen());
                  }
                  setState(() {
                    isLoading = false;
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }
}
