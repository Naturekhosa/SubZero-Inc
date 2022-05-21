//this class hold the users listing details
// this makes it easier to track individual details of the listing
//such as the item name, the category and the description
// along with the imageURL of their item

class UserListingModel {
  String? uid;
  String? listingProvince;
  String? listingCity;
  String? listingID;
  String? itemName;
  String? category;
  String? description;

  String? listingTime;
  List<String>? subCategories;
  List<String>? imagesUrls;

  UserListingModel(
      {this.uid,
      this.listingProvince,
      this.listingCity,
      this.listingID,
      this.itemName,
      this.category,
      this.description,
      this.listingTime,
      this.subCategories,
      this.imagesUrls});

  //get data from server
  factory UserListingModel.fromMap(map) {
    return UserListingModel(
        uid: map['uid'],
        listingProvince: 'listingProvince',
        listingCity: 'listingCity',
        listingID: map['listingID'],
        itemName: map['itemName'],
        category: map['category'],
        listingTime: map['listingTime'],
        subCategories: map['subCategories'],
        description: map['description'],
        imagesUrls: map['imagesUrls']);
  }

  //send data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'listingProvince': listingProvince,
      'listingCity': listingCity,
      'listingID': listingID,
      'itemName': itemName,
      'category': category,
      'listingTime': listingTime,
      'subCategories': subCategories,
      'description': description,
      'imagesUrls': imagesUrls
    };
  }
}
