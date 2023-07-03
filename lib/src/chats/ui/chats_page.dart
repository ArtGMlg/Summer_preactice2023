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
                      Icons.search,
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
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xffEDF7D0),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
          ),
          child: ListView.builder(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
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
                      : Container(
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
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Text(
                              chats[index].userName[0],
                              style: const TextStyle(
                                  fontFamily: "Comfortaa-Bold",
                                  color: Colors.white),
                            ),
                          ),
                        ),
                  title: Text(
                    chats[index].userName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    chats[index].lastMessage.toString(),
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        parseDate(chats[index].date),
                        style: const TextStyle(
                          fontSize: 11,
                          fontFamily: "Ubuntu-Light",
                        ),
                      ),
                      Badge(
                        isLabelVisible: chats[index].countUnreadMessages != 0,
                        backgroundColor: const Color(0xffB7B5E4),
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
        ),
      ),
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
                    Icons.call_outlined,
                    color: Color(0xff58576b),
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
                    Icons.message_outlined,
                    color: Color(0xFF9A97C5),
                  ),
                  Text(
                    "Мессенджер",
                    style: TextStyle(
                      color: Color(0xFF9A97C5),
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
                    Icons.account_circle_outlined,
                    color: Color(0xff58576b),
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
