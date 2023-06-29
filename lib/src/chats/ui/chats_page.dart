import 'package:bootcamp_project/src/chats/models/chat.dart';
import 'package:bootcamp_project/src/chats/ui/chats_search.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ChatsPage extends StatelessWidget {
  final List<Chat> chats;

  const ChatsPage({super.key, required this.chats});

  int getWeekOfYear(DateTime date) {
    final firstDay = DateTime(date.year, 1, 1);
    final daysPassed = date.difference(firstDay).inDays;
    return (daysPassed / 7).ceil();
  }

  String parseDate(DateTime? date) {
    final weekDays = <String>["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"];
    final months = <String>[
      "Янв.",
      "Фев.",
      "Мар.",
      "Апр.",
      "Май",
      "Июн.",
      "Июл.",
      "Авг.",
      "Сент.",
      "Окт.",
      "Нояб.",
      "Дек."
    ];
    var d = date!;
    var td = DateTime.now();
    if (d.year == td.year && getWeekOfYear(d) == getWeekOfYear(td)) {
      return weekDays[d.weekday - 1];
    } else if (d.year == td.year && d.month == td.month && d.day == td.day) {
      return "${d.hour}:${d.minute}";
    } else if (d.year == td.year) {
      return "${d.day} ${months[d.month - 1]}";
    } else {
      return "${d.day} ${months[d.month - 1]} ${d.year}";
    }
  }

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
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchScreen(chats: chats),
                        ),
                      )
                    },
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
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          if (chats[index].lastMessage != null) {
            return ListTile(
              onTap: () => {},
              leading: chats[index].userAvatar != null
                  ? CircleAvatar(
                      backgroundImage: AssetImage(
                        "${chats[index].userAvatar}",
                      ),
                    )
                  : CircleAvatar(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: <Color>[
                                Color((math.Random().nextDouble() * 0xFFFFFF)
                                        .toInt())
                                    .withOpacity(1.0),
                                Colors.white,
                              ]),
                        ),
                      ),
                    ),
              title: Text(chats[index].userName),
              subtitle: Text(
                chats[index].lastMessage.toString(),
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    parseDate(chats[index].date),
                    style: const TextStyle(fontSize: 11),
                  ),
                  Badge(
                    isLabelVisible: chats[index].countUnreadMessages != 0,
                    backgroundColor: const Color(0xff92B7CB),
                    label: Text("${chats[index].countUnreadMessages}"),
                  )
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
      // ListView(
      //   padding: EdgeInsets.zero,
      //   children: [
      //     ListTile(
      //       onTap: () => {},
      //       leading: const CircleAvatar(
      //         backgroundImage: AssetImage('assets/avatars/1.jpg'),
      //       ),
      //       title: const Text("Роман"),
      //       subtitle: const Text(
      //         "Привет, ты подготовился к буткемпу?",
      //         overflow: TextOverflow.ellipsis,
      //       ),
      //       trailing: const Column(
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: [
      //           Text(
      //             "1 фев",
      //             style: TextStyle(fontSize: 11),
      //           ),
      //           Padding(
      //             padding: EdgeInsets.only(bottom: 0.0),
      //             child: Badge(
      //               backgroundColor: Color(0xff92B7CB),
      //               label: Text("100"),
      //               alignment: Alignment.center,
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
