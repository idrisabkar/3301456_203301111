// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, unnecessary_null_comparison

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:ruso_chat/components/MaterialBox.dart';
import 'package:ruso_chat/components/constants.dart';
import 'package:ruso_chat/screens/mainChatScreen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ruso_chat/screens/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const id = "LoginScreen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  final _auth = FirebaseAuth.instance;
  late User logUser;
  late bool showSpin = false;
  bool obsText = true;
  bool controler = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 57, 185, 214),
      body: ModalProgressHUD(
        inAsyncCall: showSpin,
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: "Logo",
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('images/send.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: KinputDecoration.copyWith(
                  hintText: "Enter Your E-mail ",
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      obscuringCharacter: "*",
                      obscureText: obsText,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: KinputDecoration.copyWith(
                        hintText: "Enter Your Password ",
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            if (controler) {
                              controler = false;
                            } else {
                              controler = true;
                            }

                            obsText = obsText ? false : true;
                          },
                        );
                      },
                      child: controler
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: MaterialBox(
                  textLabel: 'Login',
                  color: Colors.lightBlueAccent,
                  opTaped: () async {
                    setState(() {
                      showSpin = true;
                    });
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        Timer(
                            const Duration(seconds: 1),
                            () => Navigator.popAndPushNamed(
                                context, ChatScreen.id));
                      }
                    } catch (e) {
                      setState(
                        () {
                          showSpin = false;
                        },
                      );
                      Alert(
                        context: context,
                        type: AlertType.error,
                        desc: e.toString(),
                        buttons: [
                          DialogButton(
                              radius:
                                  const BorderRadius.all(Radius.circular(8)),
                              child: const Text(
                                "Retry",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                          DialogButton(
                              radius:
                                  const BorderRadius.all(Radius.circular(8)),
                              child: const Text(
                                "Sign-up",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                Navigator.popAndPushNamed(
                                    context, RegistrationScreen.id);
                              }),
                        ],
                        style: const AlertStyle(
                          backgroundColor: Colors.lightBlueAccent,
                        ),
                      ).show();
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Not a member ? ",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.popAndPushNamed(context, RegistrationScreen.id);
                    },
                    child: const Text(
                      "Sign-in!",
                      style: TextStyle(color: Colors.pinkAccent),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
