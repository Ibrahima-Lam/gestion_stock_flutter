import 'package:flutter/material.dart';
import 'package:gestion_stock_flutter/service/vente_service.dart';
import 'package:gestion_stock_flutter/vente/vente.dart';
import 'package:gestion_stock_flutter/widget/drawer_widget.dart';
import 'package:gestion_stock_flutter/widget/row_item_widget.dart';

class VentePage extends StatefulWidget {
  const VentePage({super.key});

  @override
  State<VentePage> createState() => _VentePageState();
}

class _VentePageState extends State<VentePage> {
  final VenteService _venteService = VenteService();
  List<VenteProduitClient> Ventes = [];
  bool isLoading = false;
  final String appBarTitle = 'Listes des ventes';

  void setIsloadingVente(bool val) {
    setState(() {
      isLoading = val;
    });
  }

  Future<void> getData() async {
    setIsloadingVente(true);
    Ventes = await _venteService.getVentesFromFirebase();
    setIsloadingVente(false);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title: Text(appBarTitle),
        ),
        body: SafeArea(
            child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                    children: Ventes.map(
                      (e) => ListTile(
                        leading: e.image.length == 0
                            ? Container(
                                width: 40,
                                height: 40,
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  child: Text(
                                    e.nom.toUpperCase().substring(0, 2),
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            : Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(e.image))),
                              ),
                        title: Text(e.nomClient),
                        subtitle: Text(e.nom),
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return ModalContainer(vente: e);
                              });
                        },
                      ),
                    ).toList(),
                  ),
          ),
        )),
        drawer: const DrawerWidget(),
      ),
    );
  }
}

class ModalContainer extends StatelessWidget {
  final VenteProduitClient vente;
  const ModalContainer({super.key, required this.vente});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          vente.image.length == 0
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Text(
                      vente.nom.toUpperCase().substring(0, 2),
                      style:
                          TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              : Container(
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(vente.image))),
                ),
          Container(
            child: SingleChildScrollView(
                child: Column(
              children: [
                RowItem(title: 'Nom :', content: vente.nom),
                RowItem(title: 'Description :', content: vente.description),
                RowItem(title: 'Client :', content: vente.nomClient),
                RowItem(
                    title: 'Quantite :', content: vente.quantite.toString()),
                RowItem(title: 'Date :', content: vente.date),
                RowItem(
                    title: 'Prix unitaire:', content: vente.prix.toString()),
                RowItem(
                    title: 'Prix Total:',
                    content: (vente.prix * vente.quantite).toString()),
              ],
            )),
          )
        ],
      ),
    );
  }
}
