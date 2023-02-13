import 'package:cloud_firestore/cloud_firestore.dart';

class User {

  String id;
  final String name;
  final String picture;
  final String email;
  final String password;
  final int tel;
  final int totalAchat;
  final int totalPrix;
  final DateTime date;

  User({this.id = '',required this.name,required this.picture,required this.email,required this.password,required this.totalAchat,required this.tel,required this.totalPrix, required this.date});


  add() async {
    final docUser = FirebaseFirestore.instance.collection('user').doc();

    final prod = User(
      id: docUser.id,
      name: name,
      picture: picture,
      email: email,
      password: password,
      tel: tel,
      totalAchat: totalAchat,
      totalPrix: totalPrix,
      date: date,
    );
    final json = prod.toJson();
    await docUser.set(json);
  }

  static Stream<List<User>> fetch() => FirebaseFirestore.instance
      .collection('user')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());

  static Future<User?> fetchByEmail(String email) async {
    final docUser = FirebaseFirestore.instance.collection('user').doc(email);
    final snapshot = await docUser.get();
    if(snapshot.exists){
      return User.fromJson(snapshot.data()!);
    }
  }

  Map<String,dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'picture' : picture,
    'email' : email,
    'password' : password,
    'tel' : tel,
    'totalAchat' : totalAchat,
    'totalPrix' : totalPrix,
    'date' : date,

  };

  static User fromJson(Map<String,dynamic> json) => User(
    id: json['id'],
    name: json['name'],
    picture: json['picture'],
    email: json['email'],
    password: json['password'],
    tel: json['tel'],
    totalAchat: json['totalAchat'],
    totalPrix: json['totalPrix'],
    date: (json['date'] as Timestamp).toDate(),
  );



}