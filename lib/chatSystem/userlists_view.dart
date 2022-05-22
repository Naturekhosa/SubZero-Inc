import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
//   "flutter upgrade" to upgrade flutter

class Viewlist extends StatelessWidget {
  final String description;
  final String listingProvince;
  final String listingCity;
  final String itemName;
  final String timeStamp;
  final String category;
  final String listingID;
  final imagesUrls;
  final List subCategories;

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Column(children: [
        imagesUrls.runtimeType == String
            ? Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(color: Colors.white),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(0), // Image border
                    child: AspectRatio(
                        aspectRatio: 15 / 9,
                        child: Image.network(
                          imagesUrls,
                          fit: BoxFit.fitHeight,
                        ))))
            : ClipRRect(
                borderRadius: BorderRadius.circular(0), // Image border
                child: CarouselSlider(
                  options: CarouselOptions(height: 300.0),
                  items: imagesUrls.map<Widget>((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(color: Colors.white),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(0), // Image border
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
                if ((category.toString() == "Clothing") &
                    ((subCategories[0] == "N/A") == false))
                  Text("Clothing Size :" + subCategories[0]),
                if ((category.toString() == "Food") &
                    ((subCategories[0] == "N/A") == false))
                  Text(subCategories[0]),
              ],
            ),
          ),
        ))
      ]),
    );
  }
}
