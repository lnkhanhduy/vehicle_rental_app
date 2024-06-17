import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/screens/car/register/paper_rental_screen.dart';
import 'package:vehicle_rental_app/screens/layout_screen.dart';
import 'package:vehicle_rental_app/utils/constants.dart';

class ImageRentalScreen extends StatefulWidget {
  const ImageRentalScreen({super.key});

  @override
  State<ImageRentalScreen> createState() => _ImageRentalScreenState();
}

class _ImageRentalScreenState extends State<ImageRentalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
          title: const Text(
            "Hình ảnh",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () => Get.to(() => const LayoutScreen()),
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
                padding: const EdgeInsets.fromLTRB(10, 40, 10, 20),
                constraints: const BoxConstraints.expand(),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(children: [
                            Container(
                                padding: const EdgeInsets.all(11),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Constants.primaryColor,
                                ),
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(
                                    "lib/assets/icons/info.png",
                                    color: Colors.white,
                                  ),
                                )),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              "Thông tin",
                              style: TextStyle(fontSize: 13),
                            )
                          ]),
                          Column(
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(5),
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Image.asset(
                                      "lib/assets/icons/dash.png",
                                      color: Colors.grey,
                                    ),
                                  )),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                "",
                                style: TextStyle(fontSize: 13),
                              )
                            ],
                          ),
                          Column(children: [
                            Container(
                                padding: const EdgeInsets.all(11),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Constants.primaryColor,
                                ),
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(
                                    "lib/assets/icons/image.png",
                                    color: Colors.white,
                                  ),
                                )),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              "Hình ảnh",
                              style: TextStyle(fontSize: 13),
                            )
                          ]),
                          Column(
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(5),
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Image.asset(
                                      "lib/assets/icons/dash.png",
                                      color: Colors.grey,
                                    ),
                                  )),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                "",
                                style: TextStyle(fontSize: 13),
                              )
                            ],
                          ),
                          Column(children: [
                            Container(
                                padding: const EdgeInsets.all(11),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.3),
                                    )),
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(
                                    "lib/assets/icons/paper.png",
                                    color: Constants.primaryColor,
                                  ),
                                )),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              "Giấy tờ",
                              style: TextStyle(fontSize: 13),
                            )
                          ]),
                          Column(
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(5),
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Image.asset(
                                      "lib/assets/icons/dash.png",
                                      color: Colors.grey,
                                    ),
                                  )),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                "",
                                style: TextStyle(fontSize: 13),
                              )
                            ],
                          ),
                          Column(children: [
                            Container(
                                padding: const EdgeInsets.all(11),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(0.3))),
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(
                                    "lib/assets/icons/dollar.png",
                                    color: Constants.primaryColor,
                                  ),
                                )),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              "Giá  thuê",
                              style: TextStyle(fontSize: 13),
                            )
                          ]),
                        ],
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
                Get.to(() => const PaperRentalScreen());
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
}
