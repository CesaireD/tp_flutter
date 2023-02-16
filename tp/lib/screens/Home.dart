import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tp/modele/produit.dart';
import '../helpers/style.dart';

import '../Search.dart';
import '../widgets/FeaturedProducts.dart';
import '../widgets/featured_card.dart';
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
  Widget buildProduit(Produit produit) => ListTile(
    leading: CircleAvatar(child: Text('${produit.price}')),
    title: Text(produit.name),
    subtitle: Text(produit.date.toIso8601String()),
  );
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
        padding: const EdgeInsets.only(left: 10.0,right: 10.0),
        margin: const EdgeInsets.all(10.0),

        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*Positioned(
                  top: 20,
                  right: 20,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {

                      },
                      child: Icon(Icons.search,),
                    ),
                  )
              ),
              Positioned(
                  top: 20,
                  right: 40,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {

                      },
                      child: Icon(Icons.search,),
                    ),
                  )
              ),*/
              Search(),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(14.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text('Meilleure vente',style: textStyle,),
                    ),
                  ),
                  TextButton(
                      onPressed: () {

                      },
                      child: const Text('Voir tout')
                  ),
                ],
              ),
              FeaturedProducts(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text('Decouverte',style: textStyle,),
                    ),
                  ),
                ],
              ),
              /*Column(
                children: [
                  StreamBuilder<List<Produit>>(
                      stream: Produit.fetch(),
                      builder: (context, snapshot) {
                        if(snapshot.hasError){
                          return const Text('');
                        }else if(snapshot.hasData){
                          final produits = snapshot.data!;
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_, index)
                          {
                            return FeaturedCard(produit: produits[index]);
                          });
                        }else{
                          return const Center(child: CircularProgressIndicator());
                        }
                      }
                  ),
                ],
              )*/



            ],
          ),
        ),
      ),
    );
  }
  
}