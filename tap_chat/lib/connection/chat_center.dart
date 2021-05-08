import 'package:xmpp_stone/xmpp_stone.dart' as xmpp;

class ChatCenter {
  xmpp.Connection _connection;
  xmpp.ChatManager _chatManager;

  ChatCenter(this._connection) {
    _chatManager = xmpp.ChatManager.getInstance(_connection);
  }

  void subscribeOnChats(Function(xmpp.Chat) onNewChat) {
    _chatManager.chatListStream.listen((chats) {
      chats.forEach(onNewChat);
    });
  }
}
