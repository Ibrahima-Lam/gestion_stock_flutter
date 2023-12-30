import 'package:gestion_stock_flutter/collection/collection.dart';

class Produit extends Collection {
  final String? idProduit;
  final String nom;
  final int prix;
  int stock;
  final String description;
  final String categorie;
  final String image;

  Produit({
    this.idProduit,
    required this.nom,
    required this.prix,
    required this.stock,
    required this.description,
    required this.categorie,
    required this.image,
  });
}
