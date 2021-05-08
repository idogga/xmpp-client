import 'package:flutter/material.dart';
import 'package:tap_chat/chat/chat.dart';
import 'package:tap_chat/widgets/chatList.dart';

class ChatPage extends StatefulWidget {
  List<Chat> chats = <Chat>[];

  @override
  _ChatPageState createState() => _ChatPageState();

  Function(Chat) function;

  void addChat(Chat chat) {
    chats.add(chat);
    function(chat);
  }
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();
    widget.function = addChat;
  }

  void addChat(Chat chat) {
    setState(() {
      print('Получено сообщение ${chat.name}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Диалоги",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16, left: 20, right: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Поиск...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                ),
              ),
            ),
            ListView.builder(
              itemCount: widget.chats.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ChatList(
                  name: widget.chats[index].name,
                  time: widget.chats[index].time,
                  imageUrl: widget.chats[index].imageUrl,
                  messageText: widget.chats[index].messageText,
                  isMessageRead: false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
