// TODO Implement this library.
import 'package:gestion_stock_flutter/collection/collection.dart';

class Client extends Collection {
  final String idClient;
  final String nom;
  final String adresse;
  final String telephone;

  Client(
      {required this.idClient,
      required this.nom,
      required this.adresse,
      required this.telephone});

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      idClient: json['idClient'],
      nom: json['nom'],
      adresse: json['adresse'],
      telephone: json['telephone'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'adresse': adresse,
      'telephone': telephone,
    };
  }
}
