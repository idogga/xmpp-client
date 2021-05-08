import 'package:tap_chat/connection/user_creditionals.dart';
import 'package:xmpp_stone/xmpp_stone.dart' as xmpp;

class XmppConnection {
  UserCreditionals _userCreditionals;
  xmpp.Connection _connection;

  XmppConnection(this._userCreditionals);

  void connect() {
    var jid = xmpp.Jid.fromFullJid(_userCreditionals.jid);
    var account = xmpp.XmppAccountSettings(_userCreditionals.jid, jid.local,
        jid.domain, _userCreditionals.password, 5222,
        resource: 'localhost', host: 'localhost');
    _connection = xmpp.Connection(account);
    _connection.connect();
  }

  bool isConnected() {
    return _connection.isOpened(); 
  } 

  xmpp.Connection GetConnection(){
    return _connection;
  }
}
