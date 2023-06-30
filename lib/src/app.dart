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
          backgroundColor: Color(0xffB7B5E4),
          foregroundColor: Color(0xffEDF7D0),
        ),
        scaffoldBackgroundColor: const Color(0xffB7B5E4),
        fontFamily: "Ubuntu",
      ),
      home: ChatsPage(
        chats: chats,
      ),
    );
  }
}
