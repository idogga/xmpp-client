import 'package:flutter/cupertino.dart';
import 'package:tap_chat/connection/xmpp_connection.dart';
import 'package:tap_chat/contact/contactPageDelegate.dart';
import 'package:tap_chat/dto/contactDto.dart';
import 'package:xmpp_stone/xmpp_stone.dart' as xmpp;

class ContactsHandler {
  xmpp.Connection _connection;

  ContactPageDelegate _contactPageDelegate;

  xmpp.RosterManager _rosterManager;

  xmpp.PresenceManager _presenceManager;

  ContactsHandler(
      XmppConnection connection, ContactPageDelegate contactPageDelegate) {
    _connection = connection.GetConnection();

    var presenceManager = xmpp.PresenceManager.getInstance(_connection);
    var rosterManager = xmpp.RosterManager.getInstance(_connection);
    var cardManager = xmpp.VCardManager.getInstance(_connection);

    var jid = xmpp.Jid("test", "450d0675de28", "localhost");

    _contactPageDelegate = contactPageDelegate;
    _rosterManager = rosterManager;
    _presenceManager = presenceManager;

    rosterManager.rosterStream.listen((streamEvent) {
      sendBuddies();
    });

    presenceManager.subscribe(jid);

    presenceManager.errorStream.listen((event) {
      var b = event;
    });

    presenceManager.presenceStream.listen((event) {
      var b = event.jid;
    });

    presenceManager.subscriptionStream.listen((streamEvent) {
      if (streamEvent.type == xmpp.SubscriptionEventType.REQUEST) {
        var vcard = cardManager.getVCardFor(streamEvent.jid);
        vcard.asStream().listen((event) {
          var contactDto = ContactDto(streamEvent.jid, event.nickName, "");
          _contactPageDelegate.UpdateSubscribers(contactDto);
        });
      }
      if (streamEvent.type == xmpp.SubscriptionEventType.ACCEPTED) {}
      if (streamEvent.type == xmpp.SubscriptionEventType.DECLINED) {}
    });
  }

  void sendBuddies() {
    var buddies = _rosterManager.getRoster();
    _contactPageDelegate.UpdateState(buddies);
  }
}
