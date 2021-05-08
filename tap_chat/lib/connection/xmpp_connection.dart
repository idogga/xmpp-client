import 'package:tap_chat/chat/chat.dart';
import 'package:tap_chat/connection/chat_center.dart';
import 'package:tap_chat/connection/messages_center.dart';
import 'package:tap_chat/connection/user_creditionals.dart';
import 'package:xmpp_stone/xmpp_stone.dart' as xmpp;

class XmppConnection {
  UserCreditionals _userCreditionals;
  xmpp.Connection _connection;
  MessageCenter _messageCenter;
  ChatCenter chatCenter;

  XmppConnection(this._userCreditionals);

  void connect() {
    var jid = xmpp.Jid.fromFullJid(_userCreditionals.jid);
    var account = xmpp.XmppAccountSettings(_userCreditionals.jid, jid.local,
        jid.domain, _userCreditionals.password, 5222,
        host: 'localhost', resource: 'localhost');
    _connection = xmpp.Connection(account);
    _connection.connect();
    chatCenter = ChatCenter(_connection, _userCreditionals);
  }

  void startMessageListen(Function(Chat) onAddChat) {
    _messageCenter = MessageCenter(_connection);
    chatCenter.subscribeOnChats((chat) => {A(onAddChat, chat)});
  }

  void A(Function(Chat) onAddChat, xmpp.Chat chat) {
    print('Принято сообщение: ${chat.jid.domain}');
    _messageCenter.subscribeOn(chat.jid, onAddChat(Chat(chat)));
  }

  void subscribeOnUser(xmpp.Jid jid, Function(xmpp.Message) onRecieve) {
    _messageCenter.subscribeOn(jid, onRecieve);
  }
}
