import 'package:flutter/material.dart';
import 'package:tap_chat/Authorization/ExampleConnectionStateChangedListener.dart';
import 'package:tap_chat/connection/user_creditionals.dart';
import 'package:tap_chat/connection/xmpp_connection.dart';
import '../main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:xmpp_stone/xmpp_stone.dart' as xmpp;

class LoginIn extends StatefulWidget {
  LoginIn({Key key}) : super(key: key);

  @override
  Auth createState() => Auth();
}

class Auth extends State<LoginIn> {
  String login = "";
  String pass = "";

  changeLogin(String text) {
    setState(() => login = text);
  }

  changePass(String text) {
    setState(() => pass = text);
  }

//метод авторизации
  checkUser() async {
    var user = UserCreditionals(login, pass);
    var conn = XmppConnection(user);
    conn.connect();
    ExampleConnectionStateChangedListener(conn.connection, context);
  }

//проверка авторизован ли уже пользователь
  checkUserIsLogin(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isUserLoggedIn = (prefs.getBool('isUserLoggedIn') ?? false);
    if (isUserLoggedIn)
      Navigator.push(
          context,
          PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) => MyHomePage()));
  }

  //представление
  @override
  Widget build(BuildContext context) {
    checkUserIsLogin(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Авторизация',
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Card(
              child: TextField(
                onChanged: changeLogin,
                autocorrect: true,
                decoration: InputDecoration(labelText: 'Login'),
              ),
            ),
            Card(
              child: TextField(
                onChanged: changePass,
                obscureText: true,
                autocorrect: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
            ),
            RaisedButton(
              child: Text('Войти'),
              onPressed: () => {checkUser()},
            )
          ],
        ),
      ),
    );
  }
}
