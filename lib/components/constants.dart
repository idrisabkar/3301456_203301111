// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

Image profile({required String gender}) {
  if (gender.toLowerCase() == 'female') {
    return const Image(image: AssetImage('images/female.png'));
  } else {
    return const Image(image: AssetImage('images/male.png'));
  }
}

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);
const Color color = Color.fromARGB(255, 57, 185, 214);
const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: color, width: 2.0),
    bottom: BorderSide(color: color, width: 2.0),
    left: BorderSide(color: color, width: 2.0),
    right: BorderSide(color: color, width: 2.0),
  ),
);

const KinputDecoration = InputDecoration(
  hintStyle: TextStyle(color: Colors.white38),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const textstyle1 = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w800,
  color: Colors.white,
);

const textstyle2 = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w300,
  color: Colors.white,
);
