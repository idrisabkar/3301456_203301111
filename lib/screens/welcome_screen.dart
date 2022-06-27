// ignore_for_file: library_private_types_in_public_api, must_be_immutable
import 'package:flutter/material.dart';
import 'package:ruso_chat/components/MaterialBox.dart';
import 'package:ruso_chat/screens/login_screen.dart';
import 'package:ruso_chat/screens/registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const id = "WelcomeScreen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });

    animation =
        ColorTween(begin: Colors.white, end: Colors.blue).animate(_controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 57, 185, 214),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: "Logo",
                    child: SizedBox(
                      height: _controller.value * 100,
                      child: Image.asset('images/send.png'),
                    ),
                  ),
                ),
                const Text(
                  'Ruso_Stack',
                  style: TextStyle(
                    fontFamily: "Pacifico",
                    fontSize: 44,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: MaterialBox(
                textLabel: 'Login',
                color: Colors.lightBlueAccent,
                opTaped: () {
                  Navigator.popAndPushNamed(context, LoginScreen.id);
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: MaterialBox(
                  textLabel: "Register",
                  color: const Color.fromARGB(255, 120, 3, 42),
                  opTaped: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                )),
          ],
        ),
      ),
    );
  }
}
