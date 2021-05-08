import 'package:flutter/material.dart';
import 'package:tap_chat/connection/chat_center.dart';
import 'package:tap_chat/connection/user_creditionals.dart';
import 'package:tap_chat/connection/xmpp_connection.dart';
import 'package:tap_chat/contact/contactPageDelegate.dart';
import 'package:tap_chat/contact/contactsHandler.dart';
import 'package:tap_chat/dto/contactDto.dart';
import 'package:tap_chat/models/contact.dart';
import 'package:tap_chat/views/theme_colors.dart';
import 'package:tap_chat/widgets/contactList.dart';
import 'package:xmpp_stone/xmpp_stone.dart';

class ContactPage extends StatefulWidget {
  XmppConnection connection;
  ChatCenter chatCenter;
  ContactPage(this.connection, this.chatCenter);
  @override
  _ContactPageState createState() => _ContactPageState(connection);
}

class _ContactPageState extends State<ContactPage> with ContactPageDelegate {
  bool _progressVisible = true;

  _ContactPageState(XmppConnection connection) {
    var conn = new XmppConnection(UserCreditionals());
    var _ = new ContactsHandler(conn, this);
  }

  List<Contact> contacts = [];

  List<Contact> subscribers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GetTitle(),
            GetSearch(),
            GetSubscribesList(),
            Divider(
              color: Colors.black,
            ),
            GetContactList(),
            GetProgressIndicator(),
          ],
        ),
      ),
    );
  }

  @override
  void UpdateState(List<Buddy> buddies) {
    setState(() {
      contacts = buddies
          .map((value) =>
              new Contact(value.jid, value.name, "lib/images/default.png"))
          .toList();
      _progressVisible = false;
    });
  }

  @override
  void UpdateSubscribers(ContactDto contactDto) {
    setState(() {
      var contact =
          Contact(contactDto.jid, contactDto.name, "lib/images/default.png");
      subscribers.add(contact);
    });
  }

  Widget GetTitle() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Контакты",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: ThemeColors.accent[50],
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.add,
                    color: ThemeColors.accent,
                    size: 20,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    "Добавить",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget GetSearch() {
    return Padding(
      padding: EdgeInsets.only(top: 16, left: 20, right: 20),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Поиск...",
          hintStyle: TextStyle(color: ThemeColors.darkGrey),
          prefixIcon: Icon(
            Icons.search,
            color: ThemeColors.darkGrey,
            size: 20,
          ),
          filled: true,
          fillColor: ThemeColors.lightGrey,
          contentPadding: EdgeInsets.all(8),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: ThemeColors.lightGrey)),
        ),
      ),
    );
  }

  Widget GetContactList() {
    return ListView.builder(
      itemCount: contacts.length,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 16),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ContactList(contacts[index], widget.chatCenter);
      },
    );
  }

  Widget GetSubscribesList() {
    return ListView.builder(
      itemCount: subscribers.length,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 16),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ContactList(subscribers[index], widget.chatCenter);
      },
    );
  }

  Widget GetProgressIndicator() {
    return Visibility(
        visible: _progressVisible,
        child: Center(
          child: SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey,
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          ),
        ));
  }
}
