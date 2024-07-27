import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vehicle_rental_app/controllers/user_controller.dart';
import 'package:vehicle_rental_app/models/user_model.dart';
import 'package:vehicle_rental_app/screens/layout_screen.dart';
import 'package:vehicle_rental_app/screens/loading_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';
import 'package:vehicle_rental_app/utils/utils.dart';

class ChangeProfileScreen extends StatefulWidget {
  late UserModel? userModel;

  ChangeProfileScreen({super.key, required this.userModel});

  @override
  State<ChangeProfileScreen> createState() => _ChangeProfileScreenState();
}

class _ChangeProfileScreenState extends State<ChangeProfileScreen> {
  final userController = Get.put(UserController());

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  String imageUrl = '';
  String selectedInfo = '';

  Uint8List? imageAvatarEdit;
  bool isLoading = false;

  Map<String, dynamic> locations = {};
  List<String> provinces = [];
  List<String> districts = [];
  List<String> wards = [];
  String? selectedProvince;
  String? selectedDistrict;
  String? selectedWard;

  TextEditingController addressRoad = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadInitialData().then((_) {
      if (widget.userModel?.address != null) {
        parseInitialAddress(widget.userModel!.address!);
      }
    });

    name = TextEditingController(text: widget.userModel!.name);
    email = TextEditingController(text: widget.userModel!.email);
    phone = TextEditingController(text: widget.userModel!.phone);
    password = TextEditingController(text: widget.userModel!.password);
    imageUrl = widget.userModel!.imageAvatar ?? '';
    selectedInfo = widget.userModel!.isPublic ? 'public' : 'private';
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
        selectedDistrict = null;
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
        selectedWard = null;
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
            onPressed: () => Get.to(() => const LayoutScreen(initialIndex: 4)),
            icon: const Icon(Icons.arrow_back_ios_outlined)),
        title: const Text(
          "Tài khoản của tôi",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: isLoading
                ? LoadingScreen()
                : Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    constraints: const BoxConstraints.expand(),
                    color: Colors.white,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Uint8List? imgAvatar =
                                await Utils.pickImage(ImageSource.gallery);
                            if (imgAvatar != null) {
                              setState(() {
                                isLoading = true;
                              });
                              if (imageUrl.isNotEmpty) {
                                await Utils.deleteImageIfExists(imageUrl);
                              }
                              await Utils.uploadImage(imgAvatar, 'users',
                                  email.text, 'imageAvatar', "Users");
                              final user =
                                  await UserController.instance.getUserData();

                              Utils.showSnackBar(
                                "Cập nhật ảnh đại diện thành công.",
                                Colors.green,
                                Icons.check,
                              );
                              setState(() {
                                widget.userModel = user;
                                imageUrl = user!.imageAvatar ?? '';
                                isLoading = false;
                              });
                            }
                          },
                          child: Stack(
                            children: [
                              SizedBox(
                                width: 120,
                                height: 120,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(100),
                                  ),
                                  child: imageAvatarEdit != null
                                      ? Image(
                                          image: MemoryImage(
                                            imageAvatarEdit!,
                                          ),
                                        )
                                      : imageUrl.isNotEmpty
                                          ? Image.network(
                                              imageUrl,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                  "lib/assets/images/no_avatar.png",
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                            )
                                          : Image.asset(
                                              "lib/assets/images/no_avatar.png",
                                              fit: BoxFit.cover,
                                            ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Constants.primaryColor,
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 50,
                                child: TextField(
                                  readOnly: true,
                                  controller: email,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.email_outlined),
                                    labelText: 'Email',
                                    border: OutlineInputBorder(),
                                    labelStyle: TextStyle(
                                      color: Color(0xff888888),
                                      fontSize: 15,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: Constants.primaryColor,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.all(12),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Container(
                                height: 50,
                                child: TextField(
                                  controller: name,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.person_outline_outlined),
                                    labelText: 'Họ và tên',
                                    border: OutlineInputBorder(),
                                    labelStyle: TextStyle(
                                      color: Color(0xff888888),
                                      fontSize: 15,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: Constants.primaryColor,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.all(12),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              TextField(
                                controller: phone,
                                style: const TextStyle(color: Colors.black),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.phone_outlined),
                                  labelText: 'Số điện thoại',
                                  border: OutlineInputBorder(),
                                  labelStyle: TextStyle(
                                    color: Color(0xff888888),
                                    fontSize: 15,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Constants.primaryColor,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.all(12),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.location_on_outlined),
                                      SizedBox(width: 5),
                                      const Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Địa chỉ ',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                              ),
                                            ),
                                            TextSpan(
                                              text: '*',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Column(
                                    children: [
                                      SizedBox(
                                        child: FormField<String>(
                                          builder:
                                              (FormFieldState<String> state) {
                                            return InputDecorator(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  borderSide: BorderSide(
                                                    color: Colors.grey
                                                        .withOpacity(0.1),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  borderSide: BorderSide(
                                                    color:
                                                        Constants.primaryColor,
                                                  ),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12),
                                              ),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton<String>(
                                                  value: selectedProvince,
                                                  hint: const Text(
                                                      'Chọn Tỉnh/Thành Phố'),
                                                  isExpanded: true,
                                                  items: provinces
                                                      .map((String key) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: key,
                                                      child: Text(locations[key]
                                                          ['name_with_type']),
                                                    );
                                                  }).toList(),
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      selectedProvince =
                                                          newValue;
                                                      final districtsData =
                                                          locations[selectedProvince]
                                                                  ['quan-huyen']
                                                              as Map<String,
                                                                  dynamic>;
                                                      districts = districtsData
                                                          .keys
                                                          .toList();
                                                      selectedDistrict = null;
                                                      selectedWard = null;
                                                      wards = [];
                                                    });
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      SizedBox(
                                        child: FormField<String>(
                                          builder:
                                              (FormFieldState<String> state) {
                                            return InputDecorator(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  borderSide: BorderSide(
                                                    color: Colors.grey
                                                        .withOpacity(0.1),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  borderSide: BorderSide(
                                                    color:
                                                        Constants.primaryColor,
                                                  ),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12),
                                              ),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton<String>(
                                                  value: selectedDistrict,
                                                  hint: const Text(
                                                      'Chọn Quận/Huyện'),
                                                  isExpanded: true,
                                                  items: districts
                                                      .map((String key) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: key,
                                                      child: Text(locations[
                                                                  selectedProvince]
                                                              [
                                                              'quan-huyen'][key]
                                                          ['name_with_type']),
                                                    );
                                                  }).toList(),
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      selectedDistrict =
                                                          newValue;
                                                      final wardsData =
                                                          locations[selectedProvince]
                                                                          [
                                                                          'quan-huyen']
                                                                      [
                                                                      selectedDistrict]
                                                                  ['xa-phuong']
                                                              as Map<String,
                                                                  dynamic>;
                                                      wards = wardsData.keys
                                                          .toList();
                                                      selectedWard = null;
                                                    });
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      SizedBox(
                                        child: FormField<String>(
                                          builder:
                                              (FormFieldState<String> state) {
                                            return InputDecorator(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  borderSide: BorderSide(
                                                    color: Colors.grey
                                                        .withOpacity(0.1),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  borderSide: BorderSide(
                                                    color:
                                                        Constants.primaryColor,
                                                  ),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12),
                                              ),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton<String>(
                                                  value: selectedWard,
                                                  hint: const Text(
                                                      'Chọn Xã/Phường'),
                                                  isExpanded: true,
                                                  items:
                                                      wards.map((String key) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: key,
                                                      child: Text(locations[
                                                                          selectedProvince]
                                                                      [
                                                                      'quan-huyen']
                                                                  [
                                                                  selectedDistrict]
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
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      TextField(
                                        controller: addressRoad,
                                        decoration: InputDecoration(
                                          labelText: 'Số nhà/Tên đường',
                                          border: OutlineInputBorder(),
                                          labelStyle: TextStyle(
                                            color: Color(0xff888888),
                                            fontSize: 15,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                              color: Constants.primaryColor,
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.all(12),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    children: [
                                      Icon(Icons.info_outline),
                                      SizedBox(width: 5),
                                      const Text(
                                        "Hiển thị thông tin",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
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
                                          isEmpty: selectedInfo == '',
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              value: selectedInfo.isNotEmpty
                                                  ? selectedInfo
                                                  : null,
                                              isDense: true,
                                              onChanged: (newValue) async {
                                                setState(() {
                                                  selectedInfo = newValue!;
                                                });
                                              },
                                              items: ['public', 'private']
                                                  .map((String info) {
                                                return DropdownMenuItem<String>(
                                                  value: info,
                                                  child: Text(info == 'private'
                                                      ? 'Ẩn'
                                                      : 'Hiển thị'),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 46,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (email.text.trim().isEmpty ||
                                            name.text.trim().isEmpty ||
                                            phone.text.trim().isEmpty ||
                                            selectedProvince == null ||
                                            selectedDistrict == null ||
                                            selectedWard == null ||
                                            addressRoad.text.trim().isEmpty) {
                                          Utils.showSnackBar(
                                              "Vui lòng điền đầy đủ thông tin!",
                                              Colors.red,
                                              Icons.error);
                                        } else if (!phone.text
                                                    .trim()
                                                    .startsWith('0') &&
                                                !phone.text
                                                    .trim()
                                                    .startsWith('84') ||
                                            (phone.text
                                                    .trim()
                                                    .startsWith('0') &&
                                                phone.text.trim().length !=
                                                    10) ||
                                            (phone.text
                                                    .trim()
                                                    .startsWith('84') &&
                                                phone.text.trim().length !=
                                                    11)) {
                                          Utils.showSnackBar(
                                            "Vui lòng nhập đúng số điện thoại!",
                                            Colors.red,
                                            Icons.error,
                                          );
                                        } else {
                                          final user = UserModel(
                                            email: email.text.trim(),
                                            name: name.text.trim(),
                                            phone: phone.text.trim(),
                                            password: password.text.trim(),
                                            address: buildCompleteAddress(),
                                            provider:
                                                widget.userModel!.provider,
                                            imageAvatar:
                                                widget.userModel!.imageAvatar,
                                            imageLicenseFront: widget
                                                .userModel!.imageLicenseFront,
                                            imageLicenseBack: widget
                                                .userModel!.imageLicenseBack,
                                            imageIdCardFront: widget
                                                .userModel!.imageIdCardFront,
                                            imageIdCardBack: widget
                                                .userModel!.imageIdCardBack,
                                            isVerified:
                                                widget.userModel!.isVerified,
                                            message: widget.userModel!.message,
                                            isAdmin: widget.userModel!.isAdmin,
                                            isPublic: selectedInfo == 'public',
                                            isRented:
                                                widget.userModel!.isRented,
                                            totalRental:
                                                widget.userModel!.totalRental,
                                            star: widget.userModel!.star,
                                          );

                                          setState(() {
                                            isLoading = true;
                                          });
                                          bool result = await userController
                                              .updateUser(user);
                                          if (result) {
                                            final user = await userController
                                                .getUserData();
                                            Utils.showSnackBar(
                                              "Cập nhật thông tin thành công.",
                                              Colors.green,
                                              Icons.check,
                                            );
                                            setState(() {
                                              widget.userModel = user;
                                              isLoading = false;
                                            });
                                          }
                                          setState(() {
                                            isLoading = false;
                                          });
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black87,
                                        foregroundColor: Colors.white,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                        ),
                                      ),
                                      child: const Text(
                                        "CẬP NHẬT",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
