import 'package:gestion_stock_flutter/produit/produit.dart';

class Vente {
  final String idVente;
  final String idClient;
  final String idProduit;
  final int quantite;
  final DateTime date;

  Vente(
      {required this.idVente,
      required this.idClient,
      required this.idProduit,
      required this.quantite,
      required this.date});
}

class VenteProduit extends Produit {
  final String idVente;
  final String idClient;
  final int quantite;
  final String date;

  VenteProduit(
      {super.idProduit,
      required super.nom,
      required super.prix,
      required super.stock,
      required super.description,
      required super.categorie,
      required super.image,
      required this.idVente,
      required this.idClient,
      required this.quantite,
      required this.date});
}

class VenteProduitClient extends VenteProduit {
  final String adresse;
  final String nomClient;
  final String telephone;

  VenteProduitClient(
      {required this.adresse,
      required this.nomClient,
      required this.telephone,
      required super.idClient,
      required super.idVente,
      required super.idProduit,
      required super.quantite,
      required super.date,
      super.nom = '',
      super.prix = 0,
      super.stock = 0,
      super.description = '',
      super.categorie = '',
      super.image = ''})
      : super();
}
