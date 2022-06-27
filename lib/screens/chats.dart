import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ruso_chat/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ruso_chat/screens/mainChatScreen.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedinUser1;
late String message1;
Radius radius = const Radius.circular(30);
TextEditingController _controller = TextEditingController();

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const MessageStream(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: kMessageContainerDecoration.copyWith(
                  borderRadius:
                      BorderRadius.only(topRight: radius, bottomLeft: radius)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onChanged: (value) {
                        setState(() {
                          message1 = value;
                        });
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _controller.clear();
                      _firestore.collection("messages").add({
                        "message": message1,
                        "user": loggedinUser1.email,
                        "date": DateTime.now(),
                        "name": userName,
                      });
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.blueGrey,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection("messages")
          .orderBy("date", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        final List<Widget> messageWidget = [];
        final messages = snapshot.data?.docs;
        if (!snapshot.hasData) {
          return Center(
            child: Column(
              children: const [
                Center(child: Text("Say Hi!")),
                CircularProgressIndicator(
                  backgroundColor: Colors.lightBlueAccent,
                ),
              ],
            ),
          );
        }
        for (var messageData in messages!) {
          final massage = messageData['message'];
          final sender = messageData['user'];
          bool whoIsIt = loggedinUser1.email == sender;
          final textmessage = TextBubble(
            text: massage,
            user: sender,
            isMe: whoIsIt,
          );
          messageWidget.add(textmessage);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            children: messageWidget,
          ),
        );
      },
    );
  }
}

class TextBubble extends StatelessWidget {
  const TextBubble(
      {Key? key, required this.text, required this.user, required this.isMe})
      : super(key: key);
  final String text;
  final String user;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.9, horizontal: 10),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              user,
              style: const TextStyle(color: Colors.black26, fontSize: 10),
            ),
            Material(
              elevation: 7,
              color: isMe ? color : Colors.pinkAccent,
              borderRadius: isMe
                  ? BorderRadius.only(
                      topLeft: radius,
                      bottomLeft: radius,
                      bottomRight: radius,
                    )
                  : BorderRadius.only(
                      topRight: radius,
                      bottomLeft: radius,
                      bottomRight: radius,
                    ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
