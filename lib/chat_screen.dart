import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'users_list.dart';
import 'email_screen.dart';
import 'messageinput_bar.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Map<String, String>> messages = [
    {
      "text": "Hi Trista, SouthEast Motors would like to send you Text messages regarding your inquiry. Is that OK?\n\nReply YES to confirm or reply STOP anytime to end.",
      "time": "9:21 AM",
      "isSent": "false",
      "initials": "LP"
    },
    {"text": "YES", "time": "9:23 AM", "isSent": "true", "initials": "TC"},
    {"text": "Hi Trista, I'm going to send an email.", "time": "9:25 AM", "isSent": "false", "initials": "LP"},
    {"text": "Sounds good.", "time": "9:23 AM", "isSent": "true", "initials": "TC"},

  ];

  TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      String formattedTime = DateFormat.jm().format(DateTime.now());

      setState(() {
        messages.add({
          "text": _messageController.text,
          "time": formattedTime,
          "isSent": "true",
          "initials": "TC",
        });
      });

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () /*{
            Navigator.pop(context);
          },*/{
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UsersListScreen()),
            );
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: Text('TC', style: TextStyle(color: Colors.black)),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Trista Conrad', style: TextStyle(color: Colors.white, fontSize: 18)),
                Text('Active', style: TextStyle(color: Colors.green, fontSize: 12)),
              ],
            ),
          ],
        ),
        actions: [Icon(Icons.more_vert, color: Colors.white)],
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                var msg = messages[index];
                return ChatBubble(
                  text: msg["text"]!,
                  time: msg["time"]!,
                  isSent: msg["isSent"] == "true",
                  initials: msg["initials"]!,
                );
              },
            ),
          ),
          MessageInputBar(controller: _messageController, onSend: _sendMessage),
          BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble, color: Colors.grey),
                label: 'Text',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.email, color: Colors.grey),
                label: 'Email',
              ),
            ],
            onTap: (index) {
              if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmailChatScreen(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final String time;
  final bool isSent;
  final String initials;

  ChatBubble({
    required this.text,
    required this.time,
    required this.isSent,
    required this.initials,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isSent) CircleAvatar(child: Text(initials)),
        if (!isSent) SizedBox(width: 5),

        Stack(
          children: [

            Container(
              constraints: BoxConstraints(maxWidth: 250),
              padding: EdgeInsets.fromLTRB(
                isSent ? 28 : 12,
                28,
                isSent ? 12 : 28,
                10,
              ),
              margin: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: isSent ? Colors.blue[100] : Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(text, style: TextStyle(fontSize: 14)),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      time,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),


            Positioned(
              top: 8,
              left: isSent ? 10 : null,
              right: isSent ? null : 10,
              child: Icon(
                isSent ? Icons.message : Icons.chat_bubble,
                size: 19,
                color: isSent ? Colors.blue[700] : Colors.grey[700],
              ),
            ),
          ],
        ),

        if (isSent) SizedBox(width: 5),
        if (isSent) CircleAvatar(child: Text(initials)),
      ],
    );
  }
}






/*
class MessageInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  MessageInputBar({required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Type a message...",
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.blue),
            onPressed: onSend,
          ),
        ],
      ),
    );
  }
}
*/
