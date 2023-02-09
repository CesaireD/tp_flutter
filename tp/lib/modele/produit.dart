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

  String id;
  final String name;
  final String picture;
  final String description;
  final String category;
  final int quantity;
  final int price;
  final bool sale;
  final DateTime date;

  Produit({this.id = '',required this.name,required this.picture,required this.description,required this.category,required this.quantity,required this.price,required this.sale,required this.date});
/*
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
*/
  //List get colors => _colors;

  //List get sizes => _sizes;


 ajouterProduit() async {
   final docProduit = FirebaseFirestore.instance.collection('ifri').doc();

   final prod = Produit(
       id: docProduit.id,
       name: name,
       picture: picture,
       description: description,
       category: category,
       quantity: quantity,
       price: price,
       sale: sale,
       date: date,
   );
   final json = prod.toJson();
   await docProduit.set(json);
 }

 static Stream<List<Produit>> fetch() => FirebaseFirestore.instance
     .collection('ifri')
     .snapshots()
     .map((snapshot) => snapshot.docs.map((doc) => Produit.fromJson(doc.data())).toList());

 static Future<Produit?> fetchByID(String id) async {
   final docProd = FirebaseFirestore.instance.collection('ifri').doc(id);
   final snapshot = await docProd.get();
   if(snapshot.exists){
     return Produit.fromJson(snapshot.data()!);
   }
 }

 Map<String,dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'picture' : picture,
    'description' : description,
    'category' : category,
    'quantity' : quantity,
    'price' : price,
    'sale' : sale,
    'date' : date,

 };

 static Produit fromJson(Map<String,dynamic> json) => Produit(
     id: json['id'],
     name: json['name'],
     picture: json['picture'],
     description: json['description'],
     category: json['category'],
     quantity: json['quantity'],
     price: json['price'],
     sale: json['sale'],
     date: (json['date'] as Timestamp).toDate(),
 );


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