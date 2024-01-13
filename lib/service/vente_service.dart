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

    return VenteProduitClient.fromJson(vente, client: client, produit: produit);
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
        data['idVente'] = id;
        print('-' * 50);
        print(data);
        final Client client =
            clients.where((c) => data['idClient'] == c.idClient).toList()[0];
        final Produit produit =
            produits.where((c) => data['idProduit'] == c.idProduit).toList()[0];
        VenteProduitClient vente =
            VenteProduitClient.fromJson(data, client: client, produit: produit);

        Ventes.add(vente);
      }
      return Ventes;
    } catch (e) {
      return Ventes;
    }
  }

  Future<List<Vente>> getVentesFromFirebaseWhere({
    String? idProduit,
  }) async {
    List<Vente> list = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('vente')
              .where('idProduit', isEqualTo: idProduit)
              .get();
      for (QueryDocumentSnapshot<Map<String, dynamic>> docs
          in querySnapshot.docs) {
        Map<String, dynamic> data = docs.data();
        data['idVente'] = docs.id;
        list.add(Vente.fromJson(data));
      }
    } catch (e) {}
    return list;
  }

  Future<void> setVenteToFirebase({
    required Vente vente,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('vente')
          .doc(vente.idVente)
          .set(vente.toJson());
    } catch (e) {}
  }
}
