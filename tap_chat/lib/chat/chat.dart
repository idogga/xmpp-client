import 'package:xmpp_stone/xmpp_stone.dart' as xmpp;

class Chat {
  xmpp.Chat _chat;

  String get name => _chat.jid.fullJid;
  String get messageText => '';
  String get imageUrl => 'lib/images/default.png';
  DateTime get time => DateTime.now();
  bool get isMessageRead => true;

  Chat(this._chat);
}
