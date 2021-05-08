import 'package:flutter/material.dart';
import 'package:tap_chat/connection/user_creditionals.dart';
import 'package:tap_chat/connection/xmpp_connection.dart';
import 'package:tap_chat/views/contactPage.dart';
import 'package:tap_chat/views/profilePage.dart';

import 'views/chatPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Тап чат',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Chats'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 1;
  XmppConnection _connection;
  ChatPage _chatPage;

  _MyHomePageState() {
    var creds = UserCreditionals();
    _connection = XmppConnection(creds);
    _chatPage = ChatPage();
  }

  @override
  void initState() {
    super.initState();
    _connection.connect();
    _connection.startMessageListen(_chatPage.addChat);
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [ContactPage(), _chatPage, ProfilePage()];

    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.group_work),
            label: "Контакты",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Диалоги",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: "Профиль",
          ),
        ],
      ),
    );
  }
}
