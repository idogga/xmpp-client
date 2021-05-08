import 'package:flutter/material.dart';
import 'package:tap_chat/chat/chat.dart';
import 'package:tap_chat/connection/chat_center.dart';
import 'package:tap_chat/connection/user_creditionals.dart';

import 'chat_screen_state.dart';

class ChatScreen extends StatefulWidget {
  Chat chat;
  ChatCenter chatCenter;
  UserCreditionals get user => chatCenter.userCreditionals;

  ChatScreen(this.chat, this.chatCenter);

  @override
  State createState() => ChatScreenState();
}
