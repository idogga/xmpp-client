class UserCreditionals {
  static final UserCreditionals _singleton = UserCreditionals._internal();

  factory UserCreditionals() {
    return _singleton;
  }

  UserCreditionals._internal();

  String password;

  String userName;

  String get domain => '450d0675de28';

  String get jid => '$userName';

  void SetUser(String login, String pass) {
    password = "1234";
    //pass;
    userName = "artyom@tap";
    // login;
  }
}
