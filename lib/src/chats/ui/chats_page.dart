import 'package:bootcamp_project/src/chats/models/chat.dart';
import 'package:flutter/material.dart';

class ChatsPage extends StatelessWidget {
  final List<Chat> chats;

  const ChatsPage({super.key, required this.chats});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  IconButton(
                    onPressed: () => {},
                    icon: const Icon(Icons.horizontal_split),
                  ),
                ],
              ),
            ),
            const Expanded(
              flex: 9,
              child: Column(
                children: [
                  Text("Мессенджер"),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  IconButton(
                    onPressed: () => {},
                    icon: const Icon(
                      Icons.search,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      drawer: const Drawer(),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            onTap: () => {},
            leading: const CircleAvatar(
              backgroundImage: AssetImage('assets/avatars/1.jpg'),
            ),
            title: const Text("Роман"),
            subtitle: const Text(
              "Привет, ты подготовился к буткемпу?",
              overflow: TextOverflow.ellipsis,
            ),
            trailing: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "1 фев",
                  style: TextStyle(fontSize: 11),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 0.0),
                  child: Badge(
                    backgroundColor: Color(0xff92B7CB),
                    label: Text("100"),
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
