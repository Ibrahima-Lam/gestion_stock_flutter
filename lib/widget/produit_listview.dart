import 'package:flutter/material.dart';
import 'package:gestion_stock_flutter/categorie/categorie.dart';
import 'package:gestion_stock_flutter/produit/produit.dart';
import 'package:gestion_stock_flutter/produit/single_produit.dart';

// ignore: must_be_immutable
class ProduitListView extends StatelessWidget {
  final Categorie categorie;
  List<Produit> Produits;

  bool isLoading = false;
  ProduitListView({super.key, required this.categorie, required this.Produits});

  List<Produit> filtreProduit() {
    if (categorie.id == 'tous') return Produits;
    return Produits.where((element) => categorie.id == element.categorie)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Produit> listeFiltreProduit = filtreProduit();

    return (listeFiltreProduit.isEmpty)
        ? const Center(
            child: Text('Pas produit pour cette categorie'),
          )
        : ListView(
            children: listeFiltreProduit
                .map((elmt) => ListTile(
                    leading: elmt.image.isEmpty
                        ? SizedBox(
                            width: 40,
                            height: 40,
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: Text(
                                elmt.nom.toUpperCase().substring(0, 2),
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        : Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(elmt.image))),
                          ),
                    title: Text(elmt.nom),
                    subtitle: Text('${elmt.prix} um'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SingleProduit(produit: elmt)));
                    }))
                .toList());
  }
}
