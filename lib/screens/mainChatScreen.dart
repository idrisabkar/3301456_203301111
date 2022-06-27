// ignore_for_file: library_private_types_in_public_api, unused_field, unused_local_variable, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ruso_chat/screens/chats.dart';
import 'package:ruso_chat/screens/login_screen.dart';
import 'package:ruso_chat/screens/userProfile.dart';
import 'package:ruso_chat/screens/weatherScreen.dart';

Radius radius = const Radius.circular(30);

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const id = "ChatScreen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

final _firestore = FirebaseFirestore.instance;
String userName = "";

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  TextEditingController controller = TextEditingController();
  Future<void> getUserName() async {
    try {
      final userData = await _firestore.collection("userData").get();
      for (var data in userData.docs) {
        if (data.data()['userMail'] == loggedinUser1.email) {
          setState(() {
            userName = data.data()["userName"];
          });
          break;
        }
      }
    } catch (e) {}
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedinUser1 = user;
      }
    } catch (e) {
      Alert(context: context, type: AlertType.error);
    }
  }

  @override
  void initState() {
    getCurrentUser();
    getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: null,
          actions: [
            IconButton(
                icon: const Icon(
                  Icons.logout,
                ),
                onPressed: () {
                  Alert(
                    type: AlertType.info,
                    context: context,
                    desc: "Your Session will be clossed!",
                    buttons: [
                      DialogButton(
                        color: Colors.lightBlueAccent,
                        radius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        onPressed: () {
                          _auth.signOut();
                          Navigator.popAndPushNamed(context, LoginScreen.id);
                        },
                        child: const Text("Continue"),
                      ),
                      DialogButton(
                          color: Colors.pinkAccent,
                          radius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"))
                    ],
                  ).show();
                }),
          ],
          title: const Text('⚡️Stack'),
          backgroundColor: const Color.fromARGB(255, 57, 185, 214),
          bottom: TabBar(
            tabs: [
              Tab(text: userName, icon: const Icon(Icons.person)),
              const Tab(
                text: "weather",
                icon: Icon(Icons.cloud),
              ),
              const Tab(
                text: "Questions",
                icon: Icon(Icons.chat),
              ),
            ],
          ),
        ),
        body: const TabBarView(children: [
          USerProfileScreen(),
          WeatherScreen(),
          Chats(),
        ]),
      ),
    );
  }
}
