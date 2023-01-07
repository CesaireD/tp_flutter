import 'package:flutter/material.dart';

import 'modele/produit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Produit> prodlist = [
    Produit(nom: 'Nom', path: 'https://www.elora.com/img/cms/Actu-Mode/680A5092.jpg'),
    Produit(nom: 'Nom', path: 'https://www.elora.com/img/cms/Actu-Mode/680A5092.jpg'),
  ];
  String nameof = "Name of ...";
  String ofReduct = "-50 %";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Nom')),
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                height: 150.0,
                child: Stack(
                  children: [
                   /* Image.assets(
                      'https://www.shutterstock.com/image-photo/woman-legs-christmas-socks-blurred-260nw-1534187858.jpg',
                      //'https://www.shutterstock.com/image-photo/cracks-on-surface-blue-ice-600w-655427254.jpg',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),*/
                    Image.network(
                      'https://assets.simpleviewinc.com/simpleview/image/upload/c_fill,h_891,q_50,w_1402/v1/clients/jamaica/Harmony_Hall_20180109_2015_b25b1d1a-c52a-4b9c-b88a-2e5aa5b1f5bd.jpg',
                      //'https://github.com/CesaireD/tp_flutter/blob/main/Image/9.webp',
                      //scale: 0.4,
                      //'assets/1.webp',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                    Positioned(
                        right: 1,
                      bottom: 1,
                        child: Container(
                          width: 120,
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "$nameof\n$ofReduct",
                            style: const TextStyle(fontSize: 20.0, color: Colors.blueAccent,fontWeight: FontWeight.bold),
                          ),
                        ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 1),
                    child: TextButton(
                        onPressed: () {

                        },
                        child: const Text(
                            'Categorie populaire',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.normal
                            )
                        )
                    ),
                  ),
                  const SizedBox(width: 10.0,),
                  Padding(
                    padding: EdgeInsets.only(left: 1),
                    child: TextButton(
                        onPressed: () {

                        },
                        child: const Text(
                            'Toutes les\n categories',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.normal
                            )
                        )
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0,),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   /* ListTile(
                      title: Image.network(
                        'https://github.com/CesaireD/tp_flutter/blob/main/Image/1.jpg?raw=true',
                        //'assets/1.webp',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    )*/
                  ]
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
