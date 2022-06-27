import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ruso_chat/screens/searchScreen.dart';
import 'package:ruso_chat/screens/weatherScreen.dart';
import 'chats.dart';

class USerProfileScreen extends StatefulWidget {
  static String id = "UserScreenId";
  const USerProfileScreen({Key? key}) : super(key: key);

  @override
  State<USerProfileScreen> createState() => _UserProfileState();
}

final _firestore = FirebaseFirestore.instance;
int post = 0;
String userGender = "";
String _userName = "";
String localtime = "";
late String adress;
late String updateName;
late String name;
final _fireStrore = FirebaseFirestore.instance;
TextEditingController _controller = TextEditingController();

class _UserProfileState extends State<USerProfileScreen> {
  Future<void> getUserGender() async {
    try {
      final userData = await _firestore.collection("userData").get();
      for (var data in userData.docs) {
        if (data.data()['userMail'] == loggedinUser1.email) {
          setState(() {
            userGender = data.data()['gender'];
          });

          return;
        }
      }
    } catch (e) {}
  }

  Future getPostNum() async {
    try {
      final userData = await _firestore.collection("messages").get();
      for (var data in userData.docs) {
        if (data.data()['user'] == loggedinUser1.email) {
          setState(() {
            post += 1;
          });
        }
      }
    } catch (e) {}
  }

  Future<void> getUserName() async {
    try {
      final userData = await _firestore.collection("userData").get();
      for (var data in userData.docs) {
        if (data.data()['userMail'] == loggedinUser1.email) {
          setState(() {
            _userName = data.data()["userName"];
          });
          break;
        }
      }
    } catch (e) {}
  }

  @override
  void initState() {
    getPostNum();
    getUserName();
    getUserGender();
    super.initState();
  }

  @override
  void deactivate() {
    post = 0;
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    getUserName();
    setState(() {
      localtime = DateTime.now().toString().substring(0, 16);
      adress = region == "" ? "Loading...." : "$region $country";
    });
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 243, 189, 1),
      body: SafeArea(
        child: ListView(
          itemExtent: 739,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('images/back2.jpeg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.8), BlendMode.dstATop),
                ),
              ),
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onDoubleTap: () => showSearch(
                          context: context,
                          delegate: SearChScreen(),
                        ),
                        child: Container(
                          height: 40,
                          width: 300,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.search),
                              ),
                              SizedBox(width: 40),
                              Text("Double Tap to Search......"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(userGender == "Female"
                            ? "images/female.png"
                            : "images/male.png"),
                      ),
                      Text(
                        _userName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${loggedinUser1.email}",
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, top: 40),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(256, 0, 0, 0.5),
                      ),
                      child: Column(
                        children: [
                          Tile(
                            subtitle: _userName,
                            title: "Desplay Name",
                            icon: const Icon(
                              Icons.person,
                              size: 50,
                              color: Color.fromARGB(255, 241, 241, 241),
                            ),
                            onLongTap: () {
                              Alert(
                                context: context,
                                desc: "Update Your user Name",
                                type: AlertType.info,
                                content: TextField(
                                  controller: _controller,
                                  onChanged: (value) {
                                    setState(() {
                                      updateName = value;
                                    });
                                  },
                                ),
                                buttons: [
                                  DialogButton(
                                    color: Colors.pinkAccent,
                                    child: const Text(
                                      "Update",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      final userData = _fireStrore
                                          .collection('userData')
                                          .doc(loggedinUser1.email);
                                      userData.update({"userName": updateName});
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              ).show();
                            },
                          ),
                          Tile(
                            subtitle: "${loggedinUser1.email}",
                            title: "Email Adress",
                            icon: const Icon(
                              Icons.mail,
                              size: 50,
                              color: Color.fromARGB(255, 249, 247, 247),
                            ),
                          ),
                          Tile(
                            subtitle: post.toString(),
                            title: "Post",
                            icon: const Icon(
                              Icons.post_add,
                              size: 50,
                              color: Color.fromARGB(255, 244, 241, 241),
                            ),
                          ),
                          Tile(
                            subtitle: adress,
                            title: "Adress",
                            icon: const Icon(
                              Icons.home,
                              size: 50,
                              color: Color.fromARGB(255, 251, 248, 248),
                            ),
                          ),
                          Tile(
                            subtitle: localtime,
                            title: "Local Time",
                            icon: const Icon(
                              Icons.timer,
                              size: 50,
                              color: Color.fromARGB(255, 249, 247, 247),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onLongTap,
    Key? key,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final Icon icon;
  final VoidCallback? onLongTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: onLongTap,
      leading: icon,
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
