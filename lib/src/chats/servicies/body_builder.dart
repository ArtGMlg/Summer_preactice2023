import 'package:bootcamp_project/src/chats/models/chat.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:bordered_text/bordered_text.dart';

class BodyBuilder {
  int _getWeekOfYear(DateTime date) {
    final firstDay = DateTime(date.year, 1, 1);
    final daysPassed = date.difference(firstDay).inDays;
    return (daysPassed / 7).ceil();
  }

  String _parseDate(DateTime? date) {
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
    if (d.year == td.year && _getWeekOfYear(d) == _getWeekOfYear(td)) {
      return weekDays[d.weekday - 1];
    } else if (d.year == td.year && d.month == td.month && d.day == td.day) {
      return "${d.hour}:${d.minute}";
    } else if (d.year == td.year) {
      return "${d.day} ${months[d.month - 1]}";
    } else {
      return "${d.day} ${months[d.month - 1]} ${d.year}";
    }
  }

  Widget build(List<Chat> chats) {
    chats = chats.where((element) => element.lastMessage != null).toList();
    chats.sort((a, b) => b.date!.compareTo(a.date!));
    return Container(
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
        child: chats.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 20.0),
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
                                    Color((math.Random().nextDouble() *
                                                0xFFFFFF)
                                            .toInt())
                                        .withOpacity(1.0),
                                    Colors.white,
                                  ],
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: BorderedText(
                                  strokeColor: Colors.black,
                                  strokeWidth: 2.4,
                                  child: Text(
                                    chats[index].userName[0],
                                    style: const TextStyle(
                                        fontFamily: "Comfortaa-Bold",
                                        color: Colors.white),
                                  ),
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
                            _parseDate(chats[index].date),
                            style: const TextStyle(
                              fontSize: 11,
                              fontFamily: "Ubuntu-Light",
                            ),
                          ),
                          Badge(
                            isLabelVisible:
                                chats[index].countUnreadMessages != 0,
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
              )
            : Center(
                child: RichText(
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: "Нет чатов ",
                      style: TextStyle(
                        fontFamily: "Comfortaa-Light",
                        fontSize: 18,
                      ),
                    ),
                    TextSpan(
                      text: "🫥",
                      style: TextStyle(
                        fontFamilyFallback: [
                          'Apple Color Emoji',
                          'Noto Color Emoji',
                        ],
                        fontFamily: "Noto Color Emoji",
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              )),
      ),
    );
  }
}
