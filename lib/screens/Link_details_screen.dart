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

class LinkDetailsScreen extends StatefulWidget {
  final String listingID;

  const LinkDetailsScreen({
    Key? key,
    required this.listingID,
  }) : super(key: key);

  @override
  State<LinkDetailsScreen> createState() => _LinkDetailsScreenState();
}

class _LinkDetailsScreenState extends State<LinkDetailsScreen> {
  UserListingModel userModel = UserListingModel();

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('Listing2');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.listingID).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            backgroundColor: Colors.red,
            appBar: AppBar(title: Text(data["itemName"].toString())),
            body: Column(children: [
              Image.network(data["imagesUrls"][0].toString(),
                  height: MediaQuery.of(context).size.height * 0.4,
                  fit: BoxFit.cover),
              Expanded(
                  child: Container(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Text(
                          data["itemName"],
                          style: Theme.of(context).textTheme.headline5,
                        ), //item name display
                      ]),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: Text("Description : " +
                              data["description"].toString())),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child:
                              Text("City : " + data["listingCity"].toString())
                          //style: Theme.of(context).textTheme.headlineSmall),
                          ),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: Text("Province : " +
                              data["listingProvince"].toString())
                          //style: Theme.of(context).textTheme.headlineSmall),
                          ),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                              "Upload Date : " + data["timeStamp"].toString())
                          //style: Theme.of(context).textTheme.headlineSmall),
                          ),

                      //this adds an option for subcategories to be shown
                      if ((data["category"].toString() == "Clothing") &
                          ((data["subCategories"][0].toString() == "N/A") ==
                              false))
                        Text("Clothing Size :" +
                            data["subCategories"][0].toString()),
                      if ((data["category"].toString() == "Food") &
                          ((data["subCategories"][0].toString() == "N/A") ==
                              false))
                        Text(data["subCategories"][0].toString()),
                      if ((data["category"].toString() == "Shoes") &
                          ((data["subCategories"][0].toString() == "N/A") ==
                              false))
                        Text("Shoe Size : " +
                            data["subCategories"][0].toString()),
                    ],
                  ),
                ),
              ))
            ]),
          );
        }

        return Text("loading");
      },
    );
  }
}
