// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:app_port_cap/app/models/index.dart';
import 'package:app_port_cap/app/resources/app_colors.dart';
import 'package:app_port_cap/app/views/chat_ui/constants.dart';
import 'package:app_port_cap/app/widgets/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'Chat';

  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final datastore = GetStorage();
  late final UserModel userData;

  late String messageText;

  void getCurrentUser() {
    final currentUser = _auth.currentUser;
    try {
      if (currentUser != null) {
        loggedInUser = currentUser;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    final datastore = GetStorage();
    var result = datastore.read('user');
    // print(result);
    dynamic jsonData = jsonDecode(result);
    userData = UserModel.fromMap(jsonData);
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(context, userData.name),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const MessageStream(),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: TextField(
                        controller: messageTextController,
                        onChanged: (value) {
                          messageText = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: TTCCorpColors.ClearDay,
                            border: Border(
                                left: BorderSide(
                                    color: TTCCorpColors.Sushi, width: 0.2))),
                        child: FloatingActionButton(
                          backgroundColor: Colors.white.withOpacity(0),
                          elevation: 0,
                          onPressed: () {
                            messageTextController.clear();
                            _firestore.collection('messages').add({
                              'text': messageText,
                              'sender': loggedInUser.email,
                              'timestamp': FieldValue.serverTimestamp(),
                            });
                          },
                          child: const Text(
                            'Send',
                            style: kSendButtonTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream:
            _firestore.collection('messages').orderBy('timestamp').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: TTCCorpColors.Sushi,
                ),
              ),
            );
          }
          final messages = snapshot.data!.docs;
          List<MessageBubble> messageBubbles = [];
          for (var message in messages) {
            final currentUser = loggedInUser.email;
            final messageText = message.get('text');
            final messageSender = message.get('sender');
            final messageTime = message.get('timestamp');

            final messageBubble = MessageBubble(
              sender: messageSender,
              text: messageText,
              time: messageTime != null
                  ? messageTime.toDate().toString()
                  : 'Time not available',
              isMe: currentUser == messageSender,
            );
            messageBubbles.add(messageBubble);
          }
          return Expanded(
              child: ListView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 20.0),
                  children: messageBubbles));
        });
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {super.key,
      required this.sender,
      required this.text,
      required this.time,
      required this.isMe});

  final String sender;
  final String text;
  final String time;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 3.0),
            child: Text(
              sender,
              style:
                  const TextStyle(color: TTCCorpColors.Sushi, fontSize: 12.0),
            ),
          ),
          Material(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(isMe ? 30.0 : 0),
                  topRight: Radius.circular(isMe ? 0 : 30.0),
                  bottomLeft: const Radius.circular(30.0),
                  bottomRight: const Radius.circular(30.0)),
              elevation: 5.0,
              color: isMe ? TTCCorpColors.DeYork : TTCCorpColors.Sushi,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.white, fontSize: 15.0),
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              time.substring(0, 16),
              style: const TextStyle(
                color: TTCCorpColors.Sushi,
                fontSize: 12.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
