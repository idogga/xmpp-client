import 'package:flutter/material.dart';
import 'package:tap_chat/connection/user_creditionals.dart';
import 'package:tap_chat/connection/xmpp_connection.dart';

import 'chat_screen_state.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key key}) : super(key: key);

  void checkConnection() {
    var creditions = UserCreditionals();
    var connection = XmppConnection(creditions);
    connection.connect();
  }

  @override
  State createState() => ChatScreenState();
}
