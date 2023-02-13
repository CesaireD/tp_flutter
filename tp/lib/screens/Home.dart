import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tp/modele/produit.dart';

import '../Search.dart';
class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }

}
class HomePageState extends State<HomePage>{
  final _key = GlobalKey<ScaffoldState>();
  final _recherche = TextEditingController();
  String _dropdownValue = "Art contemporain";
  String _searchValue = '';
  final List<String> _suggestions = [
    'contemporain',
    'peinture',
    'portrait',
    'paysage',
  ];
  void dropdownCallback(String? selectedValue) {
    if(selectedValue is String){
      setState(() {
        _dropdownValue = selectedValue;
      });
    }
    switch (_dropdownValue) {
      case "Art contemporain" : {

      }
      break;
      case "Peinture abstraite" : {
        final produit = Produit(id: "1", name: "nom", picture: "photo", description: "description", category: "categori", quantity: 2, price: 1, sale: true, date: DateTime.now());
        produit.add();
      }
      break;
      case "Portrait humain" : {

      }
      break;
      case "Paysage" : {

      }
      break;
      default: {

      }
      break;

    }
  }

  Widget buildProduit(Produit produit) => ListTile(
    leading: CircleAvatar(child: Text('${produit.price}')),
    title: Text(produit.name),
    subtitle: Text(produit.date.toIso8601String()),
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: const Text("ArTBrOs"),
      ),
      body: /*Center(child: Text("Hi..."),)*/
      Container(
        padding: EdgeInsets.only(left: 10.0,right: 10.0),
        margin: EdgeInsets.all(10.0),

        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30.0,),
              Search(),
              /*Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _recherche,
                      decoration:  InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(45.7),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(45.7),
                        ),
                        //contentPadding: const EdgeInsets.only(left: 14.0,bottom: 8.0,top: 8.0),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.search,color: Colors.black,size: 35,),
                          onPressed: () {

                          },
                        ),
                        hintText: "Recherche",
                        hintStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 22.0,
                        ),
                        //border: InputBorder.none
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20.0,),
                  ElevatedButton(
                      onPressed: () {
                        
                      },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade900,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                    ),
                      child: const Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                        size: 22,
                      ),
                  )
                ],
              ),*/
              const SizedBox(height: 30.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Catégories',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30.0),
                    ),
                  ),
                  DropdownButton(
                      items: const [
                        DropdownMenuItem(value: "Art contemporain",child: Text("Art contemporain",),),
                        DropdownMenuItem(value: "Peinture abstraite",child: Text("Peinture abstraite"),),
                        DropdownMenuItem(value: "Portrait humain",child: Text("Portrait humain"),),
                        DropdownMenuItem(value: "Paysage",child: Text("Paysage"),),
                      ],
                      style: GoogleFonts.patuaOne(
                        textStyle: const TextStyle(color: Colors.black,fontSize: 20)
                      ),
                      value: _dropdownValue,
                      iconSize: 20.0,
                      onChanged: dropdownCallback,
                  )
                ],
              ),
              const SizedBox(height: 30.0,),
              StreamBuilder<List<Produit>>(
                stream: Produit.fetch(),
                  builder: (context, snapshot) {
                   if(snapshot.hasError){
                     return Text('');
                   }else if(snapshot.hasData){
                     final produits = snapshot.data!;
                     return ListView(
                       children: produits.map(buildProduit).toList(),
                     );
                   }else{
                     return Center(child: CircularProgressIndicator());
                   }
                  }
              ),
              const SizedBox(height: 30.0,),
              FutureBuilder<Produit?>(
                future: Produit.fetchByID('produits'),
                  builder: (context, snapshot) {
                  if(snapshot.hasError){
                    return Text('');
                  }else if(snapshot.hasData) {
                     final produit = snapshot.data;
                     return produit == null ? Center(child: Text("Ce produit n'existe pas")) : buildProduit(produit);
                   }else{
                     return Center(child: CircularProgressIndicator(),);
                   }
                  }
              ),
              const SizedBox(height: 30.0,),
              ElevatedButton(
                  onPressed: () {
                    final docProd = FirebaseFirestore.instance.collection('ifri').doc("2PaxuLA8LrREFQ9cQzAa");
                    docProd.update({
                      'price': 5
                    });
                  },
                  child: Text('Update')
              ),
              const SizedBox(height: 30.0,),
              ElevatedButton(
                  onPressed: () {
                    final docProd = FirebaseFirestore.instance.collection('ifri').doc("2PaxuLA8LrREFQ9cQzAa");
                    docProd.delete();
                  },
                  child: Text('Delete')
              ),
              /*SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*ElevatedButton(
                        onPressed: (){

                        },
                        style: ElevatedButton.styleFrom(

                          side: BorderSide(color: Colors.white,width: 0),
                          padding: const EdgeInsets.all(1),
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,//Colors.grey.shade50
                          //backgroundColor: MaterialStateColor.resolveWith((color) => Colors.transparent),
                        ),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.white,
                              radius: 40.0,
                              child: Icon(
                                Icons.account_balance,
                                size: 40,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "Art contemporain",
                              style: TextStyle(fontSize: 20.0, color: Colors.black),
                            )

                          ],
                        )
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.account_balance, size: 40.0,color: Colors.black,),
                          SizedBox(height: 5,),
                          Text('Art\n contemporain',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 24),), // <-- Text


                        ],
                      ),
                    ),*/
                    //const SizedBox(width: 30.0,),

                  ],
                ),
              )*/

            ],
          ),
        ),
      ),
    );
  }
  
}