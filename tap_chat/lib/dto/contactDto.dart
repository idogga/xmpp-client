import 'package:flutter/cupertino.dart';
import 'package:xmpp_stone/xmpp_stone.dart';

class ContactDto{
  Jid jid;
  String name;
  String imageURL;
  ContactDto({@required this.jid, @required this.name, @required this.imageURL});
}