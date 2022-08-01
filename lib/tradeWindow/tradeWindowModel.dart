//this class hold the users listing details
// this makes it easier to track individual details of the listing
//such as the item name, the category and the description
// along with the imageURL of their item

class TradeWindowModel {
  String? itemName;
  String? imageURL;

  TradeWindowModel({this.itemName, this.imageURL});

  //get data from server
  factory TradeWindowModel.fromMap(map) {
    return TradeWindowModel(
        itemName: map['itemName'], imageURL: map['imageURL']);
  }

  //send data to server
  Map<String, dynamic> toMap() {
    return {
      'itemName': itemName,
      'imageURL': imageURL,
    };
  }
}
