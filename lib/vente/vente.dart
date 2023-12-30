import 'package:gestion_stock_flutter/produit/produit.dart';

class Vente extends Produit {
  final String idVente;
  final String idClient;
  final String idProduit;
  final int quantite;
  final String date;

  final String adresse;
  final String nomClient;
  final String telephone;

  Vente(
      {required this.adresse,
      required this.idClient,
      required this.nomClient,
      required this.telephone,
      required this.idVente,
      required this.idProduit,
      required this.quantite,
      required this.date,
      super.nom = '',
      super.prix = 0,
      super.stock = 0,
      super.description = '',
      super.categorie = '',
      super.image = ''})
      : super();
}
