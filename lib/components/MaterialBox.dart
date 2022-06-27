// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MaterialBox extends StatelessWidget {
  MaterialBox(
      {Key? key,
      required this.textLabel,
      required this.color,
      required this.opTaped})
      : super(key: key);

  String textLabel;
  Function opTaped;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      color: color,
      borderRadius: BorderRadius.circular(30.0),
      child: MaterialButton(
        onPressed: () {
          opTaped();
        },
        minWidth: 200.0,
        height: 42.0,
        child: Text(
          textLabel,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
