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
}
