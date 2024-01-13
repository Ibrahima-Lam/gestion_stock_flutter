import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestion_stock_flutter/produit/produit.dart';

class ProduitService {
  Future<void> sendProduitTofirebase() async {
    try {
      await FirebaseFirestore.instance.collection('produit').doc('nour1').set({
        'nom': 'Riz',
        'prix': 2000,
        'stock': 10,
        'categorie': 'nourriture',
        'image': '',
        'description': 'Sac de riz 50kg',
      });
    } catch (e) {}
  }

  Future<List<Produit>> getProduitsFromFirebase() async {
    List<Produit> Produits = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('produit').get();
      for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in querySnapshot.docs) {
        Map<String, dynamic> data = documentSnapshot.data();
        final String id = documentSnapshot.id;
        data['idProduit'] = id;
        Produit produit = Produit.fromJson(data);
        Produits.add(produit);
        print(data);
      }
      return Produits;
    } catch (e) {
      return Produits;
    }
  }

  Future<void> setProduitToFirebase({
    required Produit produit,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('produit')
          .doc(produit.idProduit)
          .set(produit.toJson());
    } catch (e) {}
  }
}
