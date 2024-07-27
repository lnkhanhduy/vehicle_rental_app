import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late List<Animation<double>> animations;
  late Animation<double> rotationAnimation;
  final String loadingText = "Vui lòng chờ...";

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: false);

    animations = List.generate(
      loadingText.length,
      (index) => TweenSequence<double>([
        TweenSequenceItem(
          tween: Tween<double>(begin: 0, end: -15)
              .chain(CurveTween(curve: Curves.ease)),
          weight: 50,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: -15, end: 0)
              .chain(CurveTween(curve: Curves.ease)),
          weight: 50,
        ),
      ]).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(
            index / loadingText.length,
            (index + 1) / loadingText.length,
            curve: Curves.easeInOut,
          ),
        ),
      ),
    );

    rotationAnimation = Tween<double>(begin: 0, end: 2 * 3.14).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: rotationAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: rotationAnimation.value,
                    child: Image.asset(
                      'lib/assets/images/tire.png',
                      height: 60,
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  loadingText.length,
                  (index) {
                    return AnimatedBuilder(
                      animation: animations[index],
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, animations[index].value),
                          child: Text(
                            loadingText[index],
                            style: const TextStyle(fontSize: 20),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
