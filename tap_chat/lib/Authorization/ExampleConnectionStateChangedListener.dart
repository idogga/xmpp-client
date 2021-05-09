import 'package:flutter/cupertino.dart';
import 'package:tap_chat/connection/xmpp_connection.dart';
import 'package:xmpp_stone/xmpp_stone.dart' as xmpp;

import '../main.dart';
import 'AlertForLogin.dart';

class ExampleConnectionStateChangedListener
    implements xmpp.ConnectionStateChangedListener {
  XmppConnection _connection;
  BuildContext _context;

  ExampleConnectionStateChangedListener(
      XmppConnection connection, BuildContext context) {
    _context = context;
    _connection = connection;

    _connection.connection.connectionStateStream
        .listen(onConnectionStateChanged);
  }

  //ошибка авторизации
  void loginError() {
    Navigator.push(
        _context,
        PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __) => ErrorLogin()));
  }

  void ServerNotFount() {
    Navigator.push(
        _context,
        PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __) => NotFountServer()));
  }

  //войти
  void loginIn() async {
    //уведомление загрузки диалогов
    Navigator.push(
        _context,
        PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __) => SuccesLogin()));

    //кешируем, что user авторизован, включить когда будет кнопка выхода
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.setBool('isUserLoggedIn', false);
    //переход в приложение
    Navigator.push(
        _context,
        PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __) =>
                MyHomePage("BBBB", _connection)));
  }

  @override
  void onConnectionStateChanged(xmpp.XmppConnectionState state) {
    if (state == xmpp.XmppConnectionState.Authenticated) {
      loginIn();
      return;
    }
    if (state == xmpp.XmppConnectionState.AuthenticationFailure) {
      loginError();
      return;
    }
    if (state == xmpp.XmppConnectionState.Ready) {
      print('Connected');
      var vCardManager = xmpp.VCardManager(_connection.connection);
      vCardManager.getSelfVCard().then((vCard) {
        if (vCard != null) {
          print('Your info' + vCard.buildXmlString());
        }
      });
    }
  }
}
