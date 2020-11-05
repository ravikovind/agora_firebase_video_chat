import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call/models/contact.dart';
import 'package:video_call/provider/user_provider.dart';
import 'package:video_call/resources/chat_methods.dart';
import 'package:video_call/screens/callscreens/pickup/pickup_layout.dart';
import 'package:video_call/screens/pageviews/chats/widgets/contact_view.dart';
import 'package:video_call/screens/pageviews/chats/widgets/user_circle.dart';
import 'package:video_call/utils/universal_variables.dart';

class ChatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      scaffold: Scaffold(
        backgroundColor: UniversalVariables.blackColor,
        appBar: AppBar(
          elevation: 10.0,
          backgroundColor: Colors.black87,
          title: UserCircle(),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
                size: 25.0,
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/search_screen");
              },
            ),
          ],
        ),
        body: ChatListContainer(),
      ),
    );
  }
}

class ChatListContainer extends StatelessWidget {
  final ChatMethods _chatMethods = ChatMethods();

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: _chatMethods.fetchContacts(
            userId: userProvider.getUser.uid,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var docList = snapshot.data.docs;
              if (docList.isEmpty) {
                return Center(
                    child: Container(
                        height: MediaQuery.of(context).size.width * 0.25,
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Text(
                          "Search for your friends and family to start calling or chatting with them",
                        )));
              }
              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: docList.length,
                itemBuilder: (context, index) {
                  Contact contact = Contact.fromMap((docList[index].data()));

                  return ContactView(contact);
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
