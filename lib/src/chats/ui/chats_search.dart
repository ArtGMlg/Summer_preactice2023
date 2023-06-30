import 'package:bootcamp_project/src/chats/models/chat.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SearchScreen extends StatefulWidget {
  final List<Chat> chats;

  const SearchScreen({super.key, required this.chats});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Chat> _filteredChats = [];
  final TextEditingController _searchQueryController = TextEditingController();

  void _searchChats(String query) {
    List<Chat> chats = widget.chats;

    setState(() {
      _filteredChats = chats
          .where((element) => element.lastMessage != null)
          .toList()
          .where((element) =>
              element.lastMessage!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

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
        elevation: 0,
        leading: IconButton(
          onPressed: () => {
            _searchQueryController.clear(),
            Navigator.of(context).pop(),
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: TextField(
          controller: _searchQueryController,
          decoration: const InputDecoration(
            hintText: "Найти...",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white60),
          ),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
          onSubmitted: (String query) => _searchChats(query),
        ),
      ),
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
            itemCount: _filteredChats.length,
            itemBuilder: (context, index) {
              if (_filteredChats[index].lastMessage != null) {
                return ListTile(
                  onTap: () => {},
                  leading: _filteredChats[index].userAvatar != null
                      ? CircleAvatar(
                          backgroundImage: AssetImage(
                            "${_filteredChats[index].userAvatar}",
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
                              _filteredChats[index].userName[0],
                              style: const TextStyle(
                                  fontFamily: "Comfortaa-Bold",
                                  color: Colors.white),
                            ),
                          ),
                        ),
                  title: Text(_filteredChats[index].userName),
                  subtitle: Text(
                    _filteredChats[index].lastMessage.toString(),
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        parseDate(_filteredChats[index].date),
                        style: const TextStyle(
                          fontSize: 11,
                          fontFamily: "Ubuntu-Light",
                        ),
                      ),
                      Badge(
                        isLabelVisible:
                            _filteredChats[index].countUnreadMessages != 0,
                        backgroundColor: const Color(0xffB7B5E4),
                        label: Text(
                            "${_filteredChats[index].countUnreadMessages}"),
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
    );
  }
}
