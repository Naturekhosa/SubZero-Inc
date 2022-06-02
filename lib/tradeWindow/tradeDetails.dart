import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swap_shop/models/database_manager.dart';
import 'package:swap_shop/tradeWindow/listItems.dart';
import 'package:swap_shop/tradeWindow/tradeWindowModel.dart';

class TradeWindow extends StatefulWidget {
  String chatDocID;
  String friendUID;
  TradeWindow({Key? key, required this.chatDocID, required this.friendUID})
      : super(key: key);

  @override
  State<TradeWindow> createState() => _TradeWindowState(chatDocID, friendUID);
}

class _TradeWindowState extends State<TradeWindow> {
  CollectionReference trades =
      FirebaseFirestore.instance.collection('tradeWindows');
  TradeWindowModel tm = TradeWindowModel();
  String friendUID;
  final chatDocID;
  final currentUID = FirebaseAuth.instance.currentUser?.uid;
  String tradeWindowID = "";
  List<ListItem> itemsToTrade = [];
  String itemName = "";
  String imageURL = "";
  List yourlistings = [];

  _TradeWindowState(this.chatDocID, this.friendUID);

  @override
  void initState() {
    checkTradeWindow();
    super.initState();
  }

  addItem(String item_Name, String image_URL) async {
    tm.itemName = item_Name;
    tm.imageURL = image_URL;
    await trades.doc(tradeWindowID).collection(currentUID!).add(tm.toMap());
  }

  void checkTradeWindow() async {
    await trades
        .where('users', isEqualTo: {friendUID: null, currentUID: null})
        .limit(1)
        .get()
        .then(
          (QuerySnapshot querySnapshot) async {
            if (querySnapshot.docs.isNotEmpty) {
              setState(() {
                tradeWindowID = querySnapshot.docs.single.id;
              });
            } else {
              await trades.add({
                'users': {currentUID: null, friendUID: null},
              }).then((value) => {
                    setState(() {
                      tradeWindowID = value.id;
                    })
                  });
            }
          },
        )
        .catchError((error) {});
  }
/*   void checkTradeWindow() async {
   
        .collection('chats')
        .doc(chatDocID)
        .collection('tradeWindow');
    await trades.get().then(
      (QuerySnapshot querySnapshot) async {
        if (querySnapshot.docs.isNotEmpty) {
          setState(() {
            tradeWindowID = querySnapshot.docs.single.id;
          });
        } else {
          await trades.add({
            'users': {currentUID: null, friendUID: null},
          }).then((value) => {
                setState(() {
                  tradeWindowID = value.id;
                })
              });
        }
      },
    ).catchError((error) {});
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Trade Window"),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context, builder: (context) => Listings());
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            )),
        body: Row(
          children: <Widget>[
            FutureBuilder(
                future:
                    FireStoreDataBase().usersItems(currentUID!, tradeWindowID),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    yourlistings = snapshot.data as List;
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: ListView.builder(
                            itemCount: yourlistings.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        yourlistings[index]['imageURL'])),
                                title: Text(yourlistings[index]['itemName']),
                                onTap: () {
                                  setState(() {});
                                },
                              );
                            }),
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          ],
        )
        /* FutureBuilder(
                future: FireStoreDataBase()
                    .usersItems(currentUID!, chatDocID, tradeWindowID),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    yourlistings = snapshot.data as List;
                    Flexible(
                      child: Container(
                        color: Colors.white,
                        child: ListView.builder(
                            itemCount: yourlistings.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        yourlistings[index]['imageURL'])),
                                title: Text(yourlistings[index]['itemName']),
                                onTap: () {
                                  setState(() {});
                                },
                              );
                            }),
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }), */

        /* FutureBuilder(
          future: FireStoreDataBase()
              .usersItems(currentUID!, chatDocID, tradeWindowID),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              yourlistings = snapshot.data as List;

              return Scaffold(
                  body: Center(
                child: ListView.builder(
                    itemCount: yourlistings.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(yourlistings[index]['imageURL'])),
                        title: Text(yourlistings[index]['itemName']),
                        onTap: () {
                          setState(() {});
                        },
                      );
                    }),
              ));
            }
            return const Center(child: CircularProgressIndicator());
          }), */

        /*  */
        );
  }

  Widget Listings() {
    final uids = FirebaseAuth.instance.currentUser?.uid;
    List listings = [];
    List yourlistings = [];
    return Scaffold(
        appBar: AppBar(
          title: Text("Select An Item"),
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
                          setState(() {
                            itemName = listings[index]['itemName'];
                            imageURL = listings[index]['imagesUrls'][0];
                            ListItem item = ListItem(
                                itemName: itemName, imageURL: imageURL);
                            addItem(itemName, imageURL);
                            itemsToTrade.add(item);
                          });
                          Navigator.pop(context);
                        },
                      );
                    }),
              ));
            }

            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
