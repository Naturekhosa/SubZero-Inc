import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:swap_shop/screens/Link_details_screen.dart';
import 'package:swap_shop/screens/browse_listings.dart';
import 'package:swap_shop/screens/create_listing.dart';
import 'package:swap_shop/screens/main_navigation_drawer.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int curr = 0;
  @override
  Widget build(BuildContext context) {
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

    // Incoming Links Listener
    dynamicLinks.onLink.listen((dynamicLinkData) {
      final Uri uri = dynamicLinkData.link;
      final queryParams = uri.queryParameters;
      if (queryParams.isNotEmpty) {
        print("Incoming Link :" + queryParams["listingID"].toString());
        String x = queryParams["listingID"].toString();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LinkDetailsScreen(
                    listingID: queryParams["listingID"].toString(),
                  )),
        );
      } else {
        print(uri.toString());
        // your code here
      }
    });
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      drawer: Drawer(
        child: MainNavigationDrawer(),
      ),
      body: Center(
        child: Image.asset("assets/logo.png", fit: BoxFit.contain),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: curr,
        onTap: (index) {
          setState(() {
            curr = index;
            if (curr == 1) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => CreateListing()));
            }
            if (curr == 2) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => BrowseListings()));
            }
          });
        },
        items: [
          BottomNavigationBarItem(
              //index 0
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.red),
          BottomNavigationBarItem(
              //index 1
              icon: Icon(Icons.add),
              label: 'Create',
              backgroundColor: Colors.red),
          BottomNavigationBarItem(
              //index 2
              icon: Icon(Icons.shopping_basket),
              label: 'Browse',
              backgroundColor: Colors.red),
        ],
      ),
    );
  }
}
