import 'package:flutter/cupertino.dart';
import 'package:xmpp_stone/xmpp_stone.dart' as xmpp;

class Contact {
  xmpp.Jid jid;
  String name;
  FileImage image;

  Contact(this.jid, this.name, this.image);
}
