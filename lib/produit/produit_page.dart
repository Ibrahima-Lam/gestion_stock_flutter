// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:gestion_stock_flutter/categorie/categorie.dart';
import 'package:gestion_stock_flutter/categorie/categorie_data.dart';
import 'package:gestion_stock_flutter/produit/produit.dart';
import 'package:gestion_stock_flutter/service/produit_service.dart';
import 'package:gestion_stock_flutter/widget/delegate_widget.dart';
import 'package:gestion_stock_flutter/widget/drawer_widget.dart';
import 'package:gestion_stock_flutter/widget/produit_listview.dart';

// ignore: must_be_immutable
class ProduitPage extends StatefulWidget {
  ProduitPage({super.key});
  @override
  State<ProduitPage> createState() => _ProduitPageState();
}

class _ProduitPageState extends State<ProduitPage> {
  final ProduitService _service = ProduitService();
  List<Categorie> categories = CategorieData().categories;
  List<Produit> Produits = [];
  bool isLoading = false;

  void setIsloadingProduit(bool val) {
    setState(() {
      isLoading = val;
    });
  }

  Future<void> getData() async {
    setIsloadingProduit(true);
    Produits = await _service.getProduitsFromFirebase();
    setIsloadingProduit(false);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title: Text('Liste des Produit'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                await showSearch(
                    context: context, delegate: Delegate(words: Produits));
              },
            )
          ],
          bottom: TabBar(
              isScrollable: true,
              labelStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              tabs: [
                for (final cat in categories)
                  Tab(
                    text: cat.nom,
                  )
              ]),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : TabBarView(children: [
                for (final cat in categories)
                  ProduitListView(
                    Produits: Produits,
                    categorie: cat,
                  )
              ]),
        drawer: const DrawerWidget(),
        /*  floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            onPressed: () async {
              await _service.sendProduitTofirebase();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ProduitPage()));
            }), */
      ),
    ));
  }
}
/* 
List<Produit> listeProduit = [
  Produit(
      nom: 'PC',
      prix: 1000,
      stock: 20,
      vente: 10,
      categorie: 'electronique',
      image: ''),
  Produit(
      nom: 'Iphone',
      prix: 5000,
      stock: 30,
      vente: 3,
      categorie: 'electronique',
      image: ''),
  Produit(
      nom: 'Souris',
      prix: 100,
      stock: 40,
      vente: 35,
      categorie: 'electronique',
      image: ''),
  Produit(
      nom: 'Chaussure',
      prix: 100,
      stock: 40,
      vente: 35,
      categorie: 'cosmetique',
      image: ''),
  Produit(
      nom: 'Cable',
      prix: 100,
      stock: 40,
      vente: 35,
      categorie: 'electrique',
      image: ''),
];
 */