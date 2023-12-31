import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestion_stock_flutter/client/client.dart';
import 'package:gestion_stock_flutter/produit/produit.dart';
import 'package:gestion_stock_flutter/service/client_service.dart';
import 'package:gestion_stock_flutter/service/produit_service.dart';
import 'package:gestion_stock_flutter/vente/vente.dart';

class VenteService {
  Future<void> sendVenteTofirebase() async {
    try {
      await FirebaseFirestore.instance.collection('vente').doc('meub1').set({
        'idProduit': '',
        'idClient': '',
        'quantite': 0,
        'date': '',
      });
    } catch (e) {}
  }

  VenteProduitClient venteJoin(Map<String, dynamic> vente, List<Client> clients,
      List<Produit> produits) {
    final Client client =
        clients.where((c) => vente['idClient'] == c.idClient).toList()[0];
    final Produit produit =
        produits.where((c) => vente['idProduit'] == c.idProduit).toList()[0];

    return VenteProduitClient(
      adresse: client.adresse,
      idClient: client.idClient,
      nomClient: client.nom,
      telephone: client.telephone,
      idVente: vente['id'],
      idProduit: vente['idProduit'],
      quantite: vente['quantite'],
      date: vente['date'],
      nom: produit.nom,
      prix: produit.prix,
      stock: produit.stock,
      categorie: produit.categorie,
      image: produit.image,
      description: produit.description,
    );
  }

  Future<List<VenteProduitClient>> getVentesFromFirebase() async {
    List<VenteProduitClient> Ventes = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('vente').get();
      List<Client> clients = await ClientService().getClientsFromFirebase();
      List<Produit> produits = await ProduitService().getProduitsFromFirebase();
      for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in querySnapshot.docs) {
        Map<String, dynamic> data = documentSnapshot.data();
        final String id = documentSnapshot.id;
        data['id'] = id;
        VenteProduitClient vente = venteJoin(data, clients, produits);
        Ventes.add(vente);
        print('-' * 50);
        print(vente);
      }
      return Ventes;
    } catch (e) {
      return Ventes;
    }
  }

  Future<void> setVenteToFirebase({
    required Vente vente,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('vente')
          .doc(vente.idVente)
          .set({
        'idProduit': vente.idProduit,
        'idClient': vente.idClient,
        'quantite': vente.quantite,
        'date': vente.date,
      });
    } catch (e) {}
  }
}
