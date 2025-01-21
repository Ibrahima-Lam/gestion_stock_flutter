import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gestion_stock_flutter/categorie/categorie.dart';
import 'package:gestion_stock_flutter/produit/produit.dart';
import 'package:gestion_stock_flutter/produit/single_produit.dart';

// ignore: must_be_immutable
class ProduitListView extends StatelessWidget {
  final Categorie categorie;
  List<Produit> produits;

  bool isLoading = false;
  ProduitListView({super.key, required this.categorie, required this.produits});

  List<Produit> filtreProduit() {
    if (categorie.id == 'tous') return produits;
    return produits
        .where((element) => categorie.id == element.categorie)
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
                        : CachedNetworkImage(
                            imageUrl: elmt.image,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const Icon(Icons.image),
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.image),
                            height: 40,
                            width: 40,
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
