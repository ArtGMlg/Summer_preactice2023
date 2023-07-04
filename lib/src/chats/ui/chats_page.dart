import 'package:bootcamp_project/src/chats/models/chat.dart';
import 'package:bootcamp_project/src/chats/ui/chats_search.dart';
import 'package:flutter/material.dart';
import 'package:bootcamp_project/src/chats/servicies/body_builder.dart';
import 'package:bootcamp_project/src/chats/servicies/b_t_icons_icons.dart';

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
                    icon: const Icon(
                      BTIcons.list,
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              flex: 9,
              child: Column(
                children: [
                  Text(
                    "Мессенджер",
                    style: TextStyle(fontFamily: "Comfortaa-Bold"),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  IconButton(
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchScreen(chats: chats),
                        ),
                      )
                    },
                    icon: const Icon(
                      BTIcons.search__1_,
                      size: 20,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        elevation: 0,
      ),
      drawer: const Drawer(),
      body: BodyBuilder().build(chats),
      bottomNavigationBar: Container(
        height: 54,
        decoration: const BoxDecoration(color: Color(0xffEDF7D0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width / 3, 54),
              ),
              onPressed: () => {},
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    BTIcons.telephone,
                    color: Color(0xff58576b),
                    size: 18,
                  ),
                  Text(
                    "Звонки",
                    style: TextStyle(
                      color: Color(0xff58576b),
                      fontFamily: "Ubuntu-Light",
                      fontSize: 13,
                    ),
                  )
                ],
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width / 3, 54),
              ),
              onPressed: () => {},
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    BTIcons.chat_dots,
                    color: Color(0xFF7C79AD),
                    size: 18,
                  ),
                  Text(
                    "Мессенджер",
                    style: TextStyle(
                      color: Color(0xFF7C79AD),
                      fontFamily: "Ubuntu-Light",
                      fontSize: 13,
                    ),
                  )
                ],
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width / 3, 54),
              ),
              onPressed: () => {},
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    BTIcons.person_circle,
                    color: Color(0xff58576b),
                    size: 18,
                  ),
                  Text(
                    "Профиль",
                    style: TextStyle(
                      color: Color(0xff58576b),
                      fontFamily: "Ubuntu-Light",
                      fontSize: 13,
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
