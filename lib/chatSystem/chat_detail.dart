import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';
import 'package:intl/intl.dart';
import 'package:swap_shop/chatSystem/userlists_view.dart';
import 'package:swap_shop/models/database_manager.dart';
import 'package:swap_shop/models/user_listing_model.dart';
import 'package:swap_shop/models/user_model.dart';

var _textController = new TextEditingController();
String description = "";
String listingProvince = "";
String listingCity = "";
String itemName = "";
String timeStamp = "";
String category = "";
String listingID = "";
List imagesUrls = [];
List subCategories = [];

class ChatDetail extends StatefulWidget {
  final friendUid;

  ChatDetail({Key? key, this.friendUid}) : super(key: key);

  @override
  _ChatDetailState createState() => _ChatDetailState(friendUid);
}

class _ChatDetailState extends State<ChatDetail> {
  UserModel userModel = UserModel();
  UserListingModel userListing = UserListingModel();
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  final friendUid;
  String? friendName = "";
  String? currentUserName = "";
  String? formattedDate = "";
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  var chatDocId;
  var _textController = new TextEditingController();
  _ChatDetailState(this.friendUid);

  @override
  void initState() {
    DateTime now = DateTime.now();
    formattedDate = DateFormat('yyyy-MM-dd hh:mm').format(now);

    FirebaseFirestore.instance
        .collection("Users")
        .doc(friendUid)
        .get()
        .then((value) {
      this.userModel = UserModel.fromMap(value.data());
      setState(() {
        friendName = userModel.name;
      });
    });
    FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUserId)
        .get()
        .then((value) {
      this.userModel = UserModel.fromMap(value.data());
      setState(() {
        currentUserName = userModel.name;
      });
    });
    checkUser();
    super.initState();
  }

  void checkUser() async {
    await chats
        .where('users', isEqualTo: {friendUid: null, currentUserId: null})
        .limit(1)
        .get()
        .then(
          (QuerySnapshot querySnapshot) async {
            if (querySnapshot.docs.isNotEmpty) {
              setState(() {
                chatDocId = querySnapshot.docs.single.id;
              });
            } else {
              await chats.add({
                'users': {currentUserId: null, friendUid: null},
                'names': {currentUserId: currentUserName, friendUid: friendName}
              }).then((value) => {
                    setState(() {
                      chatDocId = value.id;
                    })
                  });
            }
          },
        )
        .catchError((error) {});
  }

  void sendMessage(String msg) {
    if (msg == '') return;
    chats.doc(chatDocId).collection('messages').add({
      'createdOn': FieldValue.serverTimestamp(),
      'uid': currentUserId,
      'friendUid': friendUid,
      'friendName': friendName,
      'msg': msg
    }).then((value) {
      _textController.text = '';
    });
  }

  bool isSender(String friend) {
    return friend == currentUserId;
  }

  Alignment getAlignment(friend) {
    if (friend == currentUserId) {
      return Alignment.topRight;
    }
    return Alignment.topLeft;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
      stream: chats
          .doc(chatDocId)
          .collection('messages')
          .orderBy('createdOn', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Something went wrong"),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text("Loading"),
          );
        }
        if (snapshot.hasData) {
          var data;
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text(friendName!),
              previousPageTitle: "Back",
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      reverse: true,
                      children: snapshot.data!.docs.map(
                        (DocumentSnapshot document) {
                          data = document.data()!;
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ChatBubble(
                              clipper: ChatBubbleClipper6(
                                nipSize: 0,
                                radius: 0,
                                type: isSender(data['uid'].toString())
                                    ? BubbleType.sendBubble
                                    : BubbleType.receiverBubble,
                              ),
                              alignment: getAlignment(data['uid'].toString()),
                              margin: EdgeInsets.only(top: 10),
                              backGroundColor: isSender(data['uid'].toString())
                                  ? Color.fromARGB(255, 193, 8, 8)
                                  : Color(0xffE7E7ED),
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.7,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          child: Text(data['msg'],
                                              style: TextStyle(
                                                  color: isSender(data['uid']
                                                          .toString())
                                                      ? Color.fromARGB(
                                                          255, 255, 255, 255)
                                                      : Colors.black),
                                              maxLines: 100,
                                              overflow: TextOverflow.ellipsis),
                                          onTap: () {
                                            data['msg'] == 'Link To Listing'
                                                ? Navigator.of(context)
                                                    .pushReplacement(MaterialPageRoute(
                                                        builder: (context) => Viewlist(
                                                            description:
                                                                description,
                                                            listingProvince:
                                                                listingProvince,
                                                            listingCity:
                                                                listingCity,
                                                            itemName: itemName,
                                                            timeStamp:
                                                                timeStamp,
                                                            category: category,
                                                            listingID:
                                                                listingID,
                                                            imagesUrls:
                                                                imagesUrls,
                                                            subCategories:
                                                                subCategories)))
                                                : null;
                                          },
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          data['createdOn'] == null
                                              ? DateTime.now().toString()
                                              : data['createdOn']
                                                  .toDate()
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: isSender(
                                                      data['uid'].toString())
                                                  ? Colors.white
                                                  : Colors.black),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: CupertinoTextField(
                            controller: _textController,
                          ),
                        ),
                      ),
                      CupertinoButton(
                          child: Icon(Icons.send_sharp),
                          onPressed: () => sendMessage(_textController.text)),
                      CupertinoButton(
                          child: Icon(Icons.attach_file),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => Listings());
                          })
                    ],
                  )
                ],
              ),
            ),
          );
        } else {
          return Container(
            child: Text("error"),
          );
        }
      },
    ));
  }

  Widget Listings() {
    final uids = FirebaseAuth.instance.currentUser?.uid;
    List listings = [];
    List yourlistings = [];
    return Scaffold(
        appBar: AppBar(
          title: Text("Select A Listing"),
        ),
        body: FutureBuilder(
          future: FireStoreDataBase().getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              yourlistings = snapshot.data as List;
              //select only listings posted by the user
              for (int i = 0; i < yourlistings.length; i += 1) {
                if (uids == yourlistings[i]['uid'].toString()) {
                  listings.add(yourlistings[i]);
                }
              }

              return Scaffold(
                  body: Center(
                child: ListView.builder(
                    itemCount: listings.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(listings[index]['imagesUrls'][0])),
                        title: Text(listings[index]['itemName']),
                        subtitle: Text(listings[index]['description']),
                        onTap: () {
                          getListingDetails(
                            listings[index]['description'],
                            listings[index]['listingProvince'],
                            listings[index]['listingCity'],
                            listings[index]['itemName'],
                            listings[index]['imagesUrls'],
                            listings[index]['subCategories'],
                            listings[index]['listingTime'],
                            listings[index]['category'],
                            listings[index]['listingID'],
                          );
                          Navigator.pop(context);
                        },
                      );
                    }),
              ));
            }

            return Text("loading");
          },
        ));
  }

  void getListingDetails(String d, String lP, String lC, String iN, List images,
      List sCategories, String tS, String c, String lID) {
    description = d;
    listingProvince = lP;
    listingCity = lC;
    itemName = iN;
    timeStamp = tS;
    category = c;
    listingID = lID;
    imagesUrls = images;
    subCategories = sCategories;
    _textController.text = "Link To Listing";
  }
}
