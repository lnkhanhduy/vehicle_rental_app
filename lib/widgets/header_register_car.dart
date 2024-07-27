import 'package:flutter/material.dart';
import 'package:vehicle_rental_app/utils/constants.dart';

class HeaderRegisterCar extends StatelessWidget {
  final bool imageScreen;
  final bool paperScreen;
  final bool priceScreen;

  const HeaderRegisterCar(
      {super.key,
      required this.imageScreen,
      required this.paperScreen,
      required this.priceScreen});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Constants.primaryColor,
                    border: Border.all(color: Constants.primaryColor)),
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
                    color: imageScreen ? Constants.primaryColor : Colors.white,
                    border: imageScreen
                        ? Border.all(color: Constants.primaryColor)
                        : Border.all(color: Colors.grey.withOpacity(0.3))),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset(
                    "lib/assets/icons/image.png",
                    color: imageScreen ? Colors.white : Constants.primaryColor,
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
                    color: paperScreen ? Constants.primaryColor : Colors.white,
                    border: paperScreen
                        ? Border.all(color: Constants.primaryColor)
                        : Border.all(color: Colors.grey.withOpacity(0.3))),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset(
                    "lib/assets/icons/paper.png",
                    color: paperScreen ? Colors.white : Constants.primaryColor,
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
          Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color:
                          priceScreen ? Constants.primaryColor : Colors.white,
                      border: priceScreen
                          ? Border.all(color: Constants.primaryColor)
                          : Border.all(color: Colors.grey.withOpacity(0.3))),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: Image.asset(
                      "lib/assets/icons/dollar.png",
                      color:
                          priceScreen ? Colors.white : Constants.primaryColor,
                    ),
                  )),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Giá  thuê",
                style: TextStyle(fontSize: 13),
              )
            ],
          ),
        ],
      ),
    );
  }
}
