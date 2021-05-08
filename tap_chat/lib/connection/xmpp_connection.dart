import 'package:tap_chat/connection/user_creditionals.dart';
import 'package:xmpp_stone/xmpp_stone.dart' as xmpp;

class XmppConnection {
  UserCreditionals _userCreditionals;
  xmpp.Connection connection;

  XmppConnection(this._userCreditionals);

  void connect() {
    var jid = xmpp.Jid.fromFullJid(_userCreditionals.jid);
    var account = xmpp.XmppAccountSettings(_userCreditionals.jid, jid.local,
        jid.domain, _userCreditionals.password, 5222,
        host: 'localhost', resource: 'localhost');
    connection = xmpp.Connection(account);
    connection.connect();
  }

  bool isConnected() {
    return connection.isOpened();
  }

  xmpp.Connection GetConnection() {
    return connection;
  }
}
