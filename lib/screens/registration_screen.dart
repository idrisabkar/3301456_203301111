// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, non_constant_identifier_names

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ruso_chat/components/MaterialBox.dart';
import 'package:ruso_chat/components/constants.dart';
import 'package:ruso_chat/screens/mainChatScreen.dart';
import 'package:ruso_chat/screens/login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  static const id = "RegistrationScreen";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String email;
  late String password;
  late String Username;
  late String Gender;
  var SelectedGender;
  final _auth = FirebaseAuth.instance;
  bool showSpiner = false;
  final _fireStrore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 57, 185, 214),
      body: ModalProgressHUD(
        inAsyncCall: showSpiner,
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Flexible(
                child: Hero(
                  tag: "Logo",
                  child: SizedBox(
                    height: 200.0,
                    child: Image(
                      image: AssetImage('images/send.png'),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    Username = value;
                  });
                },
                style: const TextStyle(color: Colors.white),
                decoration: KinputDecoration.copyWith(
                  hintText: "Enter your User Name",
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: KinputDecoration.copyWith(
                  hintText: "Enter Your E-mail",
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  style: const TextStyle(color: Colors.white),
                  obscuringCharacter: "*",
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: KinputDecoration.copyWith(
                      hintText: "Enter Your Password ")),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Select Your Gernder",
                    style: TextStyle(color: Colors.white38),
                  ),
                  DropdownButton(
                    style: const TextStyle(color: Colors.white),
                    dropdownColor: Colors.blueAccent,
                    value: SelectedGender,
                    items: const [
                      DropdownMenuItem(
                        value: "male",
                        child: Text("Male"),
                      ),
                      DropdownMenuItem(
                        value: "Female",
                        child: Text("Female"),
                      )
                    ],
                    onChanged: (value) {
                      setState(
                        () {
                          SelectedGender = value;
                        },
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: MaterialBox(
                  textLabel: "Register",
                  color: Colors.blueAccent,
                  opTaped: () async {
                    setState(() {
                      showSpiner = true;
                    });
                    try {
                      _fireStrore.collection("userData").doc(email).set({
                        "userName": Username,
                        "userMail": email,
                        "date": DateTime.now(),
                        "gender": SelectedGender,
                      });
                    } catch (e) {}

                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);

                      if (newUser != null) {
                        Timer(
                          const Duration(seconds: 1),
                          (() => {}),
                        );
                        Alert(
                          context: context,
                          type: AlertType.success,
                          buttons: [
                            DialogButton(
                              onPressed: () => Navigator.popAndPushNamed(
                                  context, ChatScreen.id),
                              radius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              child: const Text(
                                "Continue",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ).show();
                      }
                      setState(() {
                        showSpiner = false;
                      });
                    } catch (e) {
                      setState(() {
                        showSpiner = false;
                      });
                      Alert(
                              context: context,
                              type: AlertType.error,
                              desc: e.toString())
                          .show();
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "A member ? ",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.popAndPushNamed(context, LoginScreen.id);
                    },
                    child: const Text(
                      "Log-in!",
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
