class UserCreditionals {
  static final UserCreditionals _singleton = UserCreditionals._internal();

  factory UserCreditionals() {
    return _singleton;
  }

  UserCreditionals._internal();

  String password;

  String userName;

  String get domain => 'tap';

  String get jid => '$userName@$domain';

  void SetUser(String login, String pass) {
    password = pass;
    userName = login;
  }
}
