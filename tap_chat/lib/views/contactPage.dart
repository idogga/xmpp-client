import 'package:flutter/material.dart';
import 'package:tap_chat/models/Contact.dart';
import 'package:tap_chat/views/theme_colors.dart';
import 'package:tap_chat/widgets/contactList.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Contact> contacts = [
    Contact(name: "Артем Библенко", imageURL: "lib/images/default.png"),
    Contact(name: "Рома Воронцов", imageURL: "lib/images/default.png"),
    Contact(name: "Саша Леонов", imageURL: "lib/images/default.png"),
    Contact(name: "Артем Библенко", imageURL: "lib/images/default.png"),
    Contact(name: "Рома Воронцов", imageURL: "lib/images/default.png"),
    Contact(name: "Саша Леонов", imageURL: "lib/images/default.png"),
    Contact(name: "Артем Библенко", imageURL: "lib/images/default.png"),
    Contact(name: "Рома Воронцов", imageURL: "lib/images/default.png"),
    Contact(name: "Саша Леонов", imageURL: "lib/images/default.png")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Контакты",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
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
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
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
            ),
            ListView.builder(
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
            ),
          ],
        ),
      ),
    );
  }
}
