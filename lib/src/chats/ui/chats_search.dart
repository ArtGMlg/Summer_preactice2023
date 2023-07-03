import 'package:bootcamp_project/src/chats/models/chat.dart';
import 'package:flutter/material.dart';
import 'package:bootcamp_project/src/chats/servicies/body_builder.dart';

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
          .where((element) => element.lastMessage!.toLowerCase().contains(query
              .toLowerCase()
              .split(' ')
              .where((element) => !element.contains('@'))
              .join(' ')))
          .toList();
      if (query.contains('@')) {
        _filteredChats = _filteredChats
            .where(
              (element) => element.userName.toLowerCase().contains(query
                  .toLowerCase()
                  .split(' ')
                  .where((element) => element.contains('@'))
                  .join('')
                  .replaceAll('@', '')),
            )
            .toList();
      }
    });
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
            hintStyle: TextStyle(
              color: Colors.white60,
              fontFamily: "Ubuntu-Light",
            ),
          ),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
          onSubmitted: (String query) => _searchChats(query),
        ),
      ),
      body: BodyBuilder().build(_filteredChats),
    );
  }
}
