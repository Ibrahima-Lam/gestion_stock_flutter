// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:gestion_stock_flutter/categorie/categorie.dart';
import 'package:gestion_stock_flutter/categorie/categorie_data.dart';
import 'package:gestion_stock_flutter/controllers/produit_controller.dart';
import 'package:gestion_stock_flutter/widget/delegate_widget.dart';
import 'package:gestion_stock_flutter/widget/drawer_widget.dart';
import 'package:gestion_stock_flutter/widget/produit_listview.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ProduitPage extends StatefulWidget {
  const ProduitPage({super.key});
  @override
  State<ProduitPage> createState() => _ProduitPageState();
}

class _ProduitPageState extends State<ProduitPage> {
  List<Categorie> categories = CategorieData().categories;

  final ProduitController _controller = Get.put(ProduitController());
  @override
  void initState() {
    _controller.getProduitsFromFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title: const Text('Liste des Produit'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () async {
                await showSearch(
                    context: context,
                    delegate: Delegate(words: _controller.produits));
              },
            )
          ],
          bottom: TabBar(
              indicatorColor: Colors.white,
              indicatorPadding:
                  const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              labelStyle: const TextStyle(
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
        body: Obx(
          () => _controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : TabBarView(children: [
                  for (final cat in categories)
                    ProduitListView(
                      produits: _controller.produits,
                      categorie: cat,
                    )
                ]),
        ),
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
    );
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
