import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:share/share.dart';
import 'package:swap_shop/models/database_manager.dart';
import 'package:swap_shop/models/user_listing_model.dart';
import 'package:swap_shop/models/user_model.dart';
import 'package:swap_shop/screens/Link_details_screen.dart';
import 'package:swap_shop/screens/create_listing.dart';
import 'package:swap_shop/screens/details_screen.dart';
import 'package:swap_shop/screens/edit_list.dart';
import 'package:swap_shop/screens/home_screen.dart';
//   "flutter upgrade" to upgrade flutter

class Viewlist extends StatelessWidget {
  final String description;
  final String listingProvince;
  final String listingCity;
  final String itemName;
  final String timeStamp;
  final String category;
  final String listingID;
  final List imagesUrls;
  final List subCategories;
  // constructor for passing the preselect data from the userlist
  const Viewlist(
      {Key? key,
      required this.description,
      required this.listingProvince,
      required this.listingCity,
      required this.itemName,
      required this.imagesUrls,
      required this.timeStamp,
      required this.category,
      required this.listingID,
      required this.subCategories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String board;
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditList(
                            description: description,
                            listingProvince: listingProvince,
                            listingCity: listingCity,
                            itemName: itemName,
                            imagesUrls: imagesUrls,
                            subCategories: subCategories,
                            timeStamp: timeStamp,
                            category: category,
                            listingID: listingID,
                          )));
            },
            icon: Icon(
              Icons.edit,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Column(children: [
        Image.network(imagesUrls[0],
            height: MediaQuery.of(context).size.height * 0.4,
            fit: BoxFit.cover),
        Expanded(
            child: Container(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text(
                    itemName,
                    style: Theme.of(context).textTheme.headline5,
                  ), //item name display
                ]),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text("Description : " + description)),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text("City : " + listingCity)
                    //style: Theme.of(context).textTheme.headlineSmall),
                    ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text("Province : " + listingProvince)
                    //style: Theme.of(context).textTheme.headlineSmall),
                    ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text("Upload Date : " + timeStamp)
                    //style: Theme.of(context).textTheme.headlineSmall),
                    ),

                //this adds an option for subcategories to be shown
                if ((category.toString() == "Clothing") &
                    ((subCategories[0] == "N/A") == false))
                  Text("Clothing Size :" + subCategories[0]),
                if ((category.toString() == "Food") &
                    ((subCategories[0] == "N/A") == false))
                  Text(subCategories[0]),
                if ((category.toString() == "Shoes") &
                    ((subCategories[0] == "N/A") == false))
                  Text("Shoe Size : " + subCategories[0]),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: TextButton(
                      child: Text("Share"),
                      onPressed: () {
                        buildDynamicLinks(itemName, imagesUrls[0], listingID);
                      },
                    )
                    //style: Theme.of(context).textTheme.headlineSmall),
                    ),
              ],
            ),
          ),
        ))
      ]),
    );
  }
}

/// this creates a link for each listing  and attaches a listing id for each listing
/// this has been some great progress.the listing has been tested it is functional.
/// all thats left is to extract listing and point it to a view. this routing will be done in thwe main dart file
///
buildDynamicLinks(String title, String image, String docId) async {
  final dynamicLinkParams = DynamicLinkParameters(
    link: Uri.parse("https://subzeroinc.page.link/?listingID=" + docId),
    uriPrefix: "https://subzeroinc.page.link",
    androidParameters:
        const AndroidParameters(packageName: "com.example.swap_shop"),
    iosParameters: const IOSParameters(bundleId: "com.example.app.ios"),
    socialMetaTagParameters: SocialMetaTagParameters(
        description: '', imageUrl: Uri.parse("$image"), title: title),
  );
  final dynamicLink =
      await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
  print(dynamicLink.shortUrl.toString());

  print(docId);

  String desc = dynamicLink.shortUrl.toString();

  await FlutterShare.share(title: title, linkUrl: desc);
}
