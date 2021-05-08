import 'package:flutter/material.dart';
import 'package:tap_chat/connection/user_creditionals.dart';
import 'package:tap_chat/connection/xmpp_connection.dart';
import 'package:tap_chat/contact/contactPageDelegate.dart';
import 'package:tap_chat/contact/contactsHandler.dart';
import 'package:tap_chat/models/Contact.dart';
import 'package:tap_chat/widgets/contactList.dart';
import 'package:xmpp_stone/xmpp_stone.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> with ContactPageDelegate {
  bool _progressVisible = true;

  ContactsHandler _contactsHandler;
  XmppConnection _connection;

  _ContactPageState() {
    _connection = new XmppConnection(new UserCreditionals());
    _connection.connect();
    _contactsHandler = new ContactsHandler(_connection, this);
  }

  List<Contact> contacts = [];

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
              new Contact(name: value.name, imageURL: "lib/images/default.png"))
          .toList();
      _progressVisible = false;
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
                color: Colors.pink[50],
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.add,
                    color: Colors.pink,
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
          hintStyle: TextStyle(color: Colors.grey.shade600),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey.shade600,
            size: 20,
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding: EdgeInsets.all(8),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey.shade100)),
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
        return ContactList(
          name: contacts[index].name,
          imageUrl: contacts[index].imageURL,
        );
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
