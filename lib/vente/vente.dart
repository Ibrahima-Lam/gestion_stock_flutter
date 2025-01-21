import 'package:gestion_stock_flutter/client/client.dart';
import 'package:gestion_stock_flutter/produit/produit.dart';

class Vente {
  final String idVente;
  final String idClient;
  final String idProduit;
  final int quantite;
  final String date;

  Vente(
      {required this.idVente,
      required this.idClient,
      required this.idProduit,
      required this.quantite,
      required this.date});

  factory Vente.fromJson(Map<String, dynamic> json) {
    return Vente(
      idVente: json['idVente'],
      idProduit: json['idProduit'],
      idClient: json['idClient'],
      quantite: json['quantite'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idProduit': idProduit,
      'idClient': idClient,
      'quantite': quantite,
      'date': date,
    };
  }
}

class VenteProduit extends Produit {
  final String idVente;
  final String idClient;
  final int quantite;
  final String date;

  VenteProduit(
      {required super.idProduit,
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
  factory VenteProduitClient.fromJson(Map<String, dynamic> json,
      {required Client client, required Produit produit}) {
    return VenteProduitClient(
      adresse: client.adresse,
      idClient: client.idClient,
      nomClient: client.nom,
      telephone: client.telephone,
      idVente: json['idVente'],
      idProduit: json['idProduit'],
      quantite: json['quantite'],
      date: json['date'],
      nom: produit.nom,
      prix: produit.prix,
      stock: produit.stock,
      categorie: produit.categorie,
      image: produit.image,
      description: produit.description,
    );
  }
}
