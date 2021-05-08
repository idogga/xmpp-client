import 'package:flutter/material.dart';

class LoginIn extends StatefulWidget {
  LoginIn({Key key}) : super(key: key);

  @override
  Auth createState() => Auth();
}

class Auth extends State<LoginIn> {
  String login = "1";
  String pass = "";

  changeLogin(String text) {
    setState(() => login = text);
  }

  changePass(String text) {
    setState(() => pass = text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Авторизация',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
            onPressed: () => {print("login: $login\npassword: $pass")},
          )
        ],
      ),
    );
  }
}
