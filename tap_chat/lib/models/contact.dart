import 'package:flutter/cupertino.dart';
import 'package:xmpp_stone/xmpp_stone.dart';

class Contact{
  Jid jid;
  String name;
  String imageURL;
  Contact({@required this.jid, @required this.name, @required this.imageURL});
}