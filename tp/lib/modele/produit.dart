import 'package:cloud_firestore/cloud_firestore.dart';

class Produit {
  static const ID = "id";
  static const NAME = "name";
  static const PICTURE = "picture";
  static const PRICE = "price";
  static const DESCRIPTION = "description";
  static const CATEGORY = "category";
  static const FEATURED = "featured";
  static const QUANTITY = "quantity";
  static const BRAND = "brand";
  static const SALE = "sale";
  static const SIZES = "sizes";
  static const COLORS = "colors";

  String _id = "";
  String _name ="";
  String _picture ="";
  String _description= "";
  String _category="";
  String _brand="";
  int _quantity=0;
  int _price=0;
  bool _sale = false;
  bool _featured = true;
  //List _colors ;
  //List _sizes ;

  String get id => _id;

  String get name => _name;

  String get picture => _picture;

  String get brand => _brand;

  String get category => _category;

  String get description => _description;

  int get quantity => _quantity;

  int get price => _price;

  bool get featured => _featured;

  bool get sale => _sale;

  //List get colors => _colors;

  //List get sizes => _sizes;
/*
  Produit.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _brand = snapshot.data[BRAND];
    _sale = snapshot.data[SALE];
    _description = snapshot.data[DESCRIPTION] ?? " ";
    _featured = snapshot.data[FEATURED];
    _price = snapshot.data[PRICE].floor();
    _category = snapshot.data[CATEGORY];
    _colors = snapshot.data[COLORS];
    _sizes = snapshot.data[SIZES];
    _name = snapshot.data[NAME];
    _picture = snapshot.data[PICTURE];
  }
*/


}
/*
class ProduitServices {
  String collection = "ifri";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Produit>> getProducts() async =>
      _firestore.collection(collection).getDocuments("produit").then((result) {
        List<Produit> products = [];
        for (DocumentSnapshot product in result.documents) {
          products.add(Produit.fromSnapshot(product));
        }
        return products;
      });

  Future<List<Produit>> searchProducts({String? productName}) {
    // code to convert the first character to uppercase
    String searchKey = productName[0].toUpperCase() + productName!.substring(1);
    return _firestore
        .collection(collection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .getDocuments()
        .then((result) {
      List<Produit> products = [];
      for (DocumentSnapshot product in result.documents) {
        products.add(Produit.fromSnapshot(product));
      }
      return products;
    });
  }
}*/