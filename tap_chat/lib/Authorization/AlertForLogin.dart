import 'package:flutter/material.dart';

class ErrorLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Ошибка'),
      content: Text('Неверный логин или пароль'),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('ОК'),
        ),
      ],
    );
  }
}

class SuccesLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Добро пожаловать'),
      content: Text('Загрузка диалогов'),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('ОК'),
        ),
      ],
    );
  }
}
