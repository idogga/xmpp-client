import 'package:flutter/material.dart';
import '../main.dart';
import 'AlertForLogin.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  findUser(BuildContext context) async {
    if (pass != "user" || login != "user") {
      //вывод ошибки авторизации
      Navigator.push(
          context,
          PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) => ErrorLogin()));
    } else {
      //вывод уведомления
      Navigator.push(
          context,
          PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) => SuccesLogin()));
      //кешируем, что user авторизован
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isUserLoggedIn', true);
      //переход в приложение
      Navigator.push(
          context,
          PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) => MyHomePage()));
    }
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
              onPressed: () => {findUser(context)},
            )
          ],
        ),
      ),
    );
  }
}
