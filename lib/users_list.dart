import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'email_screen.dart';

class UsersListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Chats",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          ChatListTile(
            name: "Trista Conrad",
            lastMessage: "Sounds good.",
            time: "9:23 AM",
            avatarInitials: "TC",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatScreen()),
              );
            },
          ),
          ChatListTile(
            name: "John Doe",
            lastMessage: "Hey, how are you?",
            time: "Yesterday",
            avatarInitials: "JD",
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("John Doe's chat is not implemented.")),
              );
            },
          ),
        ],
      ),

    );
  }
}

class ChatListTile extends StatelessWidget {
  final String name;
  final String lastMessage;
  final String time;
  final String avatarInitials;
  final VoidCallback onTap;

  ChatListTile({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.avatarInitials,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        child: Text(avatarInitials),
      ),
      title: Text(
        name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(lastMessage),
      trailing: Text(
        time,
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}

