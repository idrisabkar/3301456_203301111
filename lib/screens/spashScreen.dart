import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:ruso_chat/screens/splashScreen2.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String id = "SplashScreen";
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.popAndPushNamed(context, Splash2.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 57, 185, 214),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: TextLiquidFill(
                loadDuration: const Duration(seconds: 2),
                waveDuration: const Duration(seconds: 2),
                boxBackgroundColor: const Color.fromARGB(255, 57, 185, 214),
                text: 'Ruso_Stack',
                waveColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 70,
                  fontFamily: 'Pacifico',
                ),
              ),
            ),
          ),
          const Expanded(
            child: Image(
              image: AssetImage('images/sender.png'),
            ),
          ),
        ],
      ),
    );
  }
}
