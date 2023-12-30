import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestion_stock_flutter/client/client.dart';

class ClientService {
  Future<void> sendClientTofirebase() async {
    try {
      await FirebaseFirestore.instance.collection('client').doc('meub1').set({
        'id': '',
        'nom': '',
        'adresse': '',
        'telephone': '',
      });
    } catch (e) {}
  }

  Future<List<Client>> getClientsFromFirebase() async {
    List<Client> Clients = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('client').get();
      for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in querySnapshot.docs) {
        Map<String, dynamic> data = documentSnapshot.data();
        final String id = documentSnapshot.id;
        Client client = Client(
          idClient: id,
          nom: data['nom'],
          adresse: data['adresse'],
          telephone: data['telephone'],
        );

        Clients.add(client);
        print(data);
      }
      return Clients;
    } catch (e) {
      return Clients;
    }
  }

  Future<void> setClientToFirebase({
    required Client client,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('client')
          .doc(client.idClient)
          .set({
        'nom': client.nom,
        'adresse': client.adresse,
        'telephone': client.telephone,
      });
    } catch (e) {}
  }
}
