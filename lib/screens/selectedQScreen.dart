import 'package:flutter/material.dart';

class SQScreen extends StatefulWidget {
  const SQScreen({Key? key, required this.msg, required this.name})
      : super(key: key);
  final String msg;
  final String name;
  @override
  State<SQScreen> createState() => _SQScreenState();
}

class _SQScreenState extends State<SQScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(6, 40, 61, 1),
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.msg,
              style: const TextStyle(
                color: Color.fromRGBO(223, 246, 255, 1),
                fontSize: 30,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "@${widget.name}",
                    style: const TextStyle(
                      color: Colors.white54,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
