import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Produit {

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


  add() async {
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

  static Future<Stream<List<Produit>>> search(String name) async {
    String searchKey = name[0].toUpperCase() + name.substring(1);
    return FirebaseFirestore.instance
        .collection('ifri')
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Produit.fromJson(doc.data())).toList());
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