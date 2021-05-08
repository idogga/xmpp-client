import 'package:xmpp_stone/xmpp_stone.dart' as xmpp;

class MessageCenter {
  xmpp.Connection _connection;
  xmpp.ChatManager _chatManager;
  xmpp.MessageHandler _messageHandler;

  MessageCenter(this._connection) {
    _chatManager = xmpp.ChatManager.getInstance(_connection);
    _messageHandler = xmpp.MessageHandler.getInstance(_connection);
  }

  void subscribeOn(xmpp.Jid jid, Function(xmpp.Message) onRecieve) {
    var chat = _chatManager.getChat(jid);
    chat.newMessageStream.listen((message) {
      print(message.text);
      onRecieve(message);
    });
  }

  void sendMessageTo(xmpp.Jid jid, String message) {
    _messageHandler.sendMessage(jid, message);
  }
}
