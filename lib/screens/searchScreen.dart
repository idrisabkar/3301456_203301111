// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ruso_chat/screens/selectedQScreen.dart';
import 'package:ruso_chat/screens/userProfile.dart';

class SearChScreen extends SearchDelegate {
  static String id = "searchScreenId";
  final CollectionReference _firebase =
      FirebaseFirestore.instance.collection("messages");
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text(
        "Start to Search",
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 57, 185, 214),
      body: StreamBuilder<QuerySnapshot>(
          stream: _firebase.snapshots().asBroadcastStream(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.pinkAccent,
                ),
              );
            } else {
              if (snapshot.data!.docs
                  .where((QueryDocumentSnapshot<Object?> element) =>
                      element['message']
                          .toString()
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                  .isEmpty) {
                return const Center(
                  child: Text("No query Founded"),
                );
              } else {
                return ListView(
                  children: [
                    ...snapshot.data!.docs
                        .where((QueryDocumentSnapshot<Object?> element) =>
                            element['message']
                                .toString()
                                .toLowerCase()
                                .contains(query.toLowerCase()))
                        .map(
                      (QueryDocumentSnapshot<Object?> data) {
                        final String message2 = data['message'];
                        final String name = data['name'];
                        return ListTile(
                          subtitle: Text(message2),
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(userGender == "Female"
                                ? "images/female.png"
                                : "images/male.png"),
                          ),
                          title: Text(
                            name,
                            style: const TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SQScreen(
                                  msg: message2,
                                  name: name,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                );
              }
            }
          }),
    );
  }
}
