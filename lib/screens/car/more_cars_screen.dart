import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/controllers/car_controller.dart';
import 'package:vehicle_rental_app/models/car_model.dart';
import 'package:vehicle_rental_app/screens/layout_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';
import 'package:vehicle_rental_app/widgets/car_card.dart';

class MoreCarsScreen extends StatefulWidget {
  final String keyword;

  const MoreCarsScreen({super.key, this.keyword = ''});

  @override
  State<MoreCarsScreen> createState() => _MoreCarsScreenState();
}

class _MoreCarsScreenState extends State<MoreCarsScreen> {
  TextEditingController keyword = TextEditingController();
  TextEditingController priceFrom = TextEditingController();
  TextEditingController priceTo = TextEditingController();

  @override
  void initState() {
    super.initState();
    keyword = TextEditingController(text: widget.keyword);
  }

  late String selectedCarCompany = 'all';
  late String selectedTransmission = 'all';

  List<String> companyCars = [
    'all',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Stack(
          children: [
            TextField(
              controller: keyword,
              onChanged: (value) {
                if (value.trim().isEmpty) {
                  setState(() {
                    keyword.text = '';
                  });
                }
              },
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  setState(() {
                    keyword.text = value.trim();
                  });
                }
              },
              decoration: const InputDecoration(
                hintText: 'Nhập từ khóa tìm xe',
                hintStyle: TextStyle(fontSize: 15),
                contentPadding: EdgeInsets.fromLTRB(10, 0, 32, 0),
              ),
            ),
            Positioned(
              right: -5,
              child: IconButton(
                onPressed: () {
                  if (keyword.text.trim().isNotEmpty) {
                    setState(() {
                      keyword.text = keyword.text;
                    });
                  }
                },
                icon: SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset('lib/assets/icons/search.png'),
                ),
              ),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => const LayoutScreen(initialIndex: 0));
              },
              icon: const Icon(Icons.close))
        ],
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 20),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Lọc xe",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Theo giá",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.42,
                          child: TextField(
                            onChanged: (value) {
                              if (value.trim().isEmpty) {
                                setState(() {
                                  priceFrom.text = '';
                                });
                              } else if (priceTo.text.trim().isNotEmpty &&
                                  double.parse(value.trim()) <
                                      double.parse(priceTo.text)) {
                                setState(() {
                                  priceFrom.text = value;
                                });
                              }
                            },
                            controller: priceFrom,
                            decoration: InputDecoration(
                              labelStyle: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                              labelText: 'Từ',
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
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.42,
                          child: TextField(
                            onChanged: (value) {
                              if (value.trim().isEmpty) {
                                setState(() {
                                  priceTo.text = '';
                                });
                              } else if (priceFrom.text.trim().isNotEmpty &&
                                  double.parse(value.trim()) >
                                      double.parse(priceFrom.text)) {
                                setState(() {
                                  priceTo.text = value;
                                });
                              }
                            },
                            controller: priceTo,
                            decoration: InputDecoration(
                              labelStyle: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                              labelText: 'Đến',
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
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Hãng xe",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    child: FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
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
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 12),
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
                              items: companyCars.map((String company) {
                                return DropdownMenuItem<String>(
                                  value: company,
                                  child: Text(
                                      company == 'all' ? 'Tất cả' : company),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Truyền động",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    child: FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
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
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 12),
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
                              items: ['all', 'automatic', 'manual']
                                  .map((String transmission) {
                                return DropdownMenuItem<String>(
                                  value: transmission,
                                  child: Text(transmission == 'all'
                                      ? 'Tất cả'
                                      : transmission == 'automatic'
                                          ? 'Số tự động'
                                          : 'Số sàn'),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedCarCompany = 'all';
                          selectedTransmission = 'all';
                          keyword.text = '';
                          priceFrom.text = '';
                          priceTo.text = '';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      child: const Text(
                        "Đặt lại",
                      ),
                    ),
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
          ),
        ),
      ),
      body: FutureBuilder<List<CarModel>?>(
        future: CarController.instance.getMoreCar(
            keyword.text.trim(),
            priceFrom.text.trim(),
            priceTo.text.trim(),
            selectedCarCompany,
            selectedTransmission),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Không tìm thấy xe có thể thuê.'));
          } else {
            List<CarModel> listCar = snapshot.data!;
            return ListView.builder(
              itemCount: listCar.length,
              itemBuilder: (context, index) {
                CarModel carModel = listCar[index];
                return Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  width: MediaQuery.of(context).size.width - 40,
                  child: CarCard(car: carModel),
                );
              },
            );
          }
        },
      ),
    );
  }

  void showModalFilter(BuildContext context) {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Lọc xe",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Theo giá",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.42,
                          child: TextField(
                            decoration: InputDecoration(
                              labelStyle: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                              labelText: 'Từ',
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
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Khoảng cách giữa hai TextField
                      Expanded(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.42,
                          child: TextField(
                            decoration: InputDecoration(
                              labelStyle: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                              labelText: 'Đến',
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
                        ),
                      ),
                    ],
                  )
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
          ),
        );
      },
    );
  }
}
