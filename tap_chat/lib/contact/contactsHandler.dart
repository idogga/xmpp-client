import 'package:tap_chat/connection/xmpp_connection.dart';
import 'package:tap_chat/contact/contactPageDelegate.dart';
import 'package:xmpp_stone/xmpp_stone.dart' as xmpp;

class ContactsHandler {
  
  xmpp.Connection _connection;

  ContactPageDelegate _contactPageDelegate;

  xmpp.RosterManager _rosterManager;

  xmpp.PresenceManager _presenceManager;

  ContactsHandler(XmppConnection connection, ContactPageDelegate contactPageDelegate){
    _connection = connection.GetConnection();

    var presenceManager = xmpp.PresenceManager.getInstance(_connection);
    var rosterManager = xmpp.RosterManager.getInstance(_connection);

    _contactPageDelegate = contactPageDelegate;
    _rosterManager = rosterManager;
    _presenceManager = presenceManager;

    rosterManager.rosterStream.listen((streamEvent) {
      sendBuddies();
    });

    presenceManager.subscriptionStream.listen((streamEvent) {
      if (streamEvent.type == xmpp.SubscriptionEventType.REQUEST) {
        presenceManager.acceptSubscription(streamEvent.jid);
      }
    });
  }

  void sendBuddies(){
    var buddies = _rosterManager.getRoster();
    _contactPageDelegate.UpdateState(buddies);
  }
}
