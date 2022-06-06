import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:math';

class Trader_profile extends StatefulWidget {
  final String listerImageUrl;
  final String listerusername;
  final String listingProvince;
  final String listingCity;
  const Trader_profile(
    { Key? key,
     
      required this.listerImageUrl,
      required this.listerusername,
      required this.listingProvince,
      required this.listingCity,

    
}) 
: super(key: key);

  @override
  State<Trader_profile> createState() => _Trader_profileState();
}

class _Trader_profileState extends State<Trader_profile> {

  
  double userRating = Random().nextDouble()*4+1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        
          
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(50),
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    
                    backgroundImage: NetworkImage(
                        "https://www.iconsdb.com/icons/preview/red/user-xxl.png"),
                    foregroundImage: NetworkImage(widget.listerImageUrl),
                    radius: 100.0,
                  ),
                  RatingBarIndicator(
                  rating: userRating,
                  itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 50.0,
                  direction: Axis.horizontal,
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(width: 1.5,color: Colors.redAccent),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white
              ),
              width: 400,
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Text(widget.listerusername,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
            ),
          ),

          //Location information
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(width: 1.5,color: Colors.redAccent),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white
              ),
              width: 400,
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerLeft,
              child: Text("Province : "+widget.listingProvince,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))
            ),
          ),  

          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(width: 1.5,color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white
              ),
              width: 400,
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerLeft,
              child: Text("City : "+widget.listingCity,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))
            ),
          ),
        ],
      ),           
    );
  }
}