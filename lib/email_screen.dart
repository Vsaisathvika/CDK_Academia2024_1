import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'email_input_bar.dart';
import 'messageinput_bar.dart';
import 'users_list.dart';
import 'chat_screen.dart';

class EmailChatScreen extends StatefulWidget {
  @override
  _EmailChatScreenState createState() => _EmailChatScreenState();
}


class _EmailChatScreenState extends State<EmailChatScreen> {
  List<Map<String, String>> emailMessages = [
    {
      "text": "Hello John, we'd love to hear your feedback about our services so far. Let us know how we're doing!",
      "time": "18:39",
      "isSent": "true",
      "subject": "2024 Camry"
    },
    {
      "text": "So far, everything has been great. Keep up the good work!",
      "time": "16:39",
      "isSent": "false"
    },
    {
      "text": "I've signed the agreement and sent it back. Please confirm receipt.",
      "time": "18:39",
      "isSent": "false"
    },
    {
      "text": "Received and confirmed. Welcome to NorthWest Autos! Let us know if you need any help.",
      "time": "17:39",
      "isSent": "true",
      "subject": "2024 Camry"
    },
    {
      "text": "That sounds good. Please let me know the next steps.",
      "time": "16:39",
      "isSent": "false"
    },
  ];

  TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      String formattedTime = DateFormat.jm().format(DateTime.now());

      setState(() {
        emailMessages.add({
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
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
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
              child: Text(
                'AD',
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Trista Conrad',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  'Active',
                  style: TextStyle(color: Colors.green, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Icon(Icons.more_vert, color: Colors.white),
        ],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: emailMessages.length,
              itemBuilder: (context, index) {
                var msg = emailMessages[index];
                return EmailChatBubble(
                  text: msg["text"]!,
                  time: msg["time"]!,
                  isSent: msg["isSent"] == "true",
                  subject: msg.containsKey("subject") ? msg["subject"] : null,
                );
              },
            ),
          ),
          EmailInputBar(controller: _messageController, onSend: _sendMessage),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
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
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(),
              ),
            );
          }
        },
      ),
    );
  }
}


class DateSeparator extends StatelessWidget {
  final String date;

  DateSeparator({required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            date,
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class EmailChatBubble extends StatelessWidget {
  final String text;
  final String time;
  final bool isSent;
  final String? subject;

  EmailChatBubble({
    required this.text,
    required this.time,
    required this.isSent,
    this.subject,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isSent)
          CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: Text(
              'AD',
              style: TextStyle(color: Colors.black),
            ),
          ),
        if (!isSent) SizedBox(width: 10),
        Flexible(
          child: Stack(
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: 280),
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: isSent ? Colors.blue[100] : Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: isSent ? Radius.circular(12) : Radius.zero,
                    bottomRight: isSent ? Radius.zero : Radius.circular(12),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (subject != null)
                      Row(
                        children: [
                          Icon(Icons.email, size: 16, color: Colors.blue),
                          SizedBox(width: 5),
                          Text(
                            "Subject: $subject",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    if (subject != null) SizedBox(height: 5),
                    Text(
                      text,
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    SizedBox(height: 5),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Sent at $time",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              // Add messaging icon on top right for incoming emails
              if (!isSent)
                Positioned(
                  top: 5,
                  right: 5,
                  child: Icon(Icons.email, size: 18, color: Colors.grey[700]),
                ),
            ],
          ),
        ),
        if (isSent) SizedBox(width: 10),
        if (isSent)
          CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: Text(
              'AD',
              style: TextStyle(color: Colors.black),
            ),
          ),
      ],
    );
  }
}

