import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ruso_chat/screens/welcome_screen.dart';

class Splash2 extends StatefulWidget {
  static String id = "SplashScreenId";
  const Splash2({Key? key}) : super(key: key);

  @override
  State<Splash2> createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.slowMiddle);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
    Timer(
      const Duration(seconds: 5),
      () {
        Navigator.popAndPushNamed(context, WelcomeScreen.id);
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  int parcent = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(40),
              child: Center(
                  child: Lottie.asset(
                'images/help.json',
                width: 400,
                height: 400,
                fit: BoxFit.fill,
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 10,
                width: controller.value * 400,
                decoration: const BoxDecoration(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
