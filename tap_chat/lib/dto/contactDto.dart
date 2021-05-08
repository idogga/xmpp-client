import 'package:flutter/cupertino.dart';
import 'package:xmpp_stone/xmpp_stone.dart';

class ContactDto {
  Jid jid;
  String name;
  FileImage image;
  ContactDto(this.jid, this.name, this.image);
}
