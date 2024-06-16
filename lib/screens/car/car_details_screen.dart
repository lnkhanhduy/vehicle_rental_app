import 'package:flutter/material.dart';
import 'package:vehicle_rental_app/utils/constants.dart';

import '../home_screen.dart';

class CarDetailsScreen extends StatefulWidget {
  final Car car;

  const CarDetailsScreen({super.key, required this.car});

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 1;
  int _totalPages = 3;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round() + 1;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
          SliverAppBar(
            expandedHeight: 240,
            flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Colors.black.withAlpha(0),
                          Colors.black12,
                          Colors.black45
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    top: constraints.maxHeight - 240.0,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          "lib/assets/images/no_car_image.png",
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 20.0,
                    right: 20.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        '$_currentPage/$_totalPages',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
            actions: [
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  // Thực hiện hành động chia sẻ
                },
              ),
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {
                  // Thực hiện hành động yêu thích
                },
              ),
            ],
            pinned: true,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: const EdgeInsets.all(20),
              constraints: const BoxConstraints.expand(),
              color: Colors.white,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Details"),
                ],
              ),
            ),
          )
        ]),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          color: Constants.primaryColor.withOpacity(0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text("633K",
                      style: TextStyle(
                          color: Constants.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  const Text(" / ngày")
                ],
              ),
              SizedBox(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constants.primaryColor,
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  child: const Text(
                    "Thuê xe",
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
