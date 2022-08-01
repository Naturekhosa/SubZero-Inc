import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FireStoreDataBase {
  List listings = [];
  List userItems = [];
  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection("Listing2");

  final CollectionReference tradeWindowRef =
      FirebaseFirestore.instance.collection("tradeWindows");

  Future getData() async {
    try {
      await collectionRef.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          listings.add(result.data());
        }
      });

      return listings;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

  Future usersItems(String? currentUID, var tradeWindowID) async {
    try {
      await tradeWindowRef
          .doc(tradeWindowID)
          .collection(currentUID!)
          .get()
          .then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          userItems.add(result.data());
        }
      });
      return userItems;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }
}
