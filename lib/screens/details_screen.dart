// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:swap_shop/chatSystem/chat_detail.dart';
import 'package:swap_shop/models/database_manager.dart';
import 'package:swap_shop/models/user_listing_model.dart';
import 'package:swap_shop/models/user_model.dart';
import 'package:swap_shop/screens/create_listing.dart';
import 'package:swap_shop/screens/details_screen.dart';
import 'package:swap_shop/screens/home_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
//   "flutter upgrade" to upgrade flutter

class DetailsScreen extends StatefulWidget {
  final String description;
  final String listingProvince;
  final String listingCity;
  final String itemName;
  final String Category;
  final String timeStamp;
  final List subCategories;
  final List imagesUrls;
  final String listerUid;
  const DetailsScreen(
      {Key? key,
      required this.description,
      required this.listingProvince,
      required this.listingCity,
      required this.itemName,
      required this.listerUid,
      required this.imagesUrls,
      required this.timeStamp,
      required this.Category,
      required this.subCategories})
      : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel userModel = UserModel();

  String? currentImageURL;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.listerUid)
        .get()
        .then((value) {
      userModel = UserModel.fromMap(value.data());
      setState(() {});
    });
    getImageURL();
  }

  Future getImageURL() async {
    var collection = FirebaseFirestore.instance.collection("Users");
    var docSnapshot = await collection.doc(widget.listerUid).get();
    Map<String, dynamic>? data = docSnapshot.data();
    currentImageURL = data?['ProfilePicture'];
  }

  @override
  Widget buildMessageButton(context) => FloatingActionButton.extended(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
        icon: Icon(Icons.message),
        label: Text('Message'),
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => ChatDetail(
                    friendUid: widget.listerUid,
                  )));
        },
      );

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(
                  "https://www.iconsdb.com/icons/preview/red/user-xxl.png"),
              foregroundImage: NetworkImage(currentImageURL.toString()),
              radius: 100,
            ),
          )
        ],
      ),
      body: Column(children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(0), // Image border
            child: CarouselSlider(
              options: CarouselOptions(height: 300.0),
              items: widget.imagesUrls.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(color: Colors.amber),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0), // Image border
                        child: AspectRatio(
                          aspectRatio: 15 / 9,
                          child: Image.network(
                            i,
                            fit: BoxFit.fill, // use this
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            )),

        Expanded(
            child: Container(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0), topRight: Radius.circular(0))),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text(userModel.username.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .headline5), //item name display
                ]),

                Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text("Item Name : " + widget.itemName)),

                Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text("Description : " + widget.description)),

                Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text("City : " + widget.listingCity)
                    //style: Theme.of(context).textTheme.headlineSmall),
                    ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text("Province : " + widget.listingProvince)
                    //style: Theme.of(context).textTheme.headlineSmall),
                    ),

                Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text("Upload Date : " + widget.timeStamp)
                    //style: Theme.of(context).textTheme.headlineSmall),
                    ),

                if ((widget.subCategories[0] == "N/A") == false)
                  Text(widget.subCategories[0]),
                //{
                // Text(subCategories[0]),
                //};
              ],
            ),
          ),
        ))
        // 40%
      ]),
      floatingActionButton: buildMessageButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
