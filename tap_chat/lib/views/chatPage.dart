import 'package:flutter/material.dart';
import 'package:tap_chat/models/chat.dart';
import 'package:tap_chat/widgets/chatList.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  List<Chat> chats = [
    Chat(name: "Артем Библенко", messageText: "Привет!", imageURL: "lib/images/default.png", time: "Now"),
  ];

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
                padding: EdgeInsets.only(left: 20,right: 20,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Диалоги",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16,left: 20,right: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Поиск...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.grey.shade100
                    )
                  ),
                ),
              ),
            ),
            ListView.builder(
              itemCount: chats.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return ChatList(
                  name: chats[index].name,
                  time: chats[index].time,
                  imageUrl: chats[index].imageURL,
                  messageText: chats[index].messageText,
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