import 'package:tap_chat/connection/user_creditionals.dart';
import 'package:xmpp_stone/xmpp_stone.dart' as xmpp;

class ChatCenter {
  xmpp.Connection _connection;
  xmpp.ChatManager _chatManager;
  UserCreditionals userCreditionals;
  xmpp.MessageHandler _messageHandler;

  ChatCenter(this._connection, this.userCreditionals) {
    _chatManager = xmpp.ChatManager.getInstance(_connection);
    _messageHandler = xmpp.MessageHandler.getInstance(_connection);
  }

  void subscribeOnChats(Function(xmpp.Chat) onNewChat) {
    _chatManager.chatListStream.listen((chats) {
      chats.forEach(onNewChat);
    });
  }

  void sendMessageTo(xmpp.Jid jid, String message) {
    _messageHandler.sendMessage(jid, message);
  }
}
