import 'package:bootcamp_project/src/chats/models/chat.dart';
import 'package:bootcamp_project/src/chats/ui/chats_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  final List<Chat> chats;

  const App({super.key, required this.chats});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff92B7CB),
          foregroundColor: Color(0xffEDF7D0),
        ),
      ),
      home: ChatsPage(
        chats: chats,
      ),
    );
  }
}
