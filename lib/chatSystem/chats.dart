import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:swap_shop/chatSystem/chat_detail.dart';
import 'lib.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  void initState() {
    super.initState();
    chatState.refreshChatsForCurrentUser();
  }

  void callChatDetailScreen(BuildContext context, String uid) {
    Navigator.push(context,
        CupertinoPageRoute(builder: (context) => ChatDetail(friendUid: uid)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Observer(
          builder: (BuildContext context) => CustomScrollView(
                slivers: [
                  CupertinoSliverNavigationBar(
                    largeTitle: Text("Chats"),
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate(
                          chatState.messages.values.toList().map((data) {
                    return CupertinoListTile(
                      focusColor: Colors.white,
                      title: Text(
                        data['friendName'],
                        style: TextStyle(color: Colors.red),
                      ),
                      subtitle: Text(data['msg'],
                          style: TextStyle(color: Colors.black)),
                      onTap: () =>
                          callChatDetailScreen(context, data['friendUid']),
                    );
                  }).toList()))
                ],
              )),
    );
  }
}
