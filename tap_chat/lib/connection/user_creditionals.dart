class UserCreditionals {
  String password;
  String userName;
  String domain;
  String get jid => '$userName@$domain';

  UserCreditionals() {
    password = "1234";
    userName = "artyom";
    domain = "tap";
  }
}
