import 'package:flutter/material.dart';
import 'package:gestion_stock_flutter/client/client.dart';
import 'package:gestion_stock_flutter/produit/produit.dart';
import 'package:gestion_stock_flutter/service/client_service.dart';
import 'package:gestion_stock_flutter/service/vente_service.dart';
import 'package:gestion_stock_flutter/vente/vente.dart';
import 'package:gestion_stock_flutter/widget/default_field_widget.dart';

class VenteForm extends StatefulWidget {
  final Produit produit;

  const VenteForm({super.key, required this.produit});

  @override
  State<VenteForm> createState() => _VenteFormState();
}

class _VenteFormState extends State<VenteForm> {
  final TextEditingController produitEditingController =
      TextEditingController();
  bool updated = false;
  List<Client> clients = [];
  String? clientValue;
  int quantiteValue = 0;
  DateTime dateValue = DateTime.now();
  bool isLoading = false;
  void setIsloading(bool val) {
    setState(() {
      isLoading = val;
    });
  }

  Future<void> getData() async {
    setIsloading(true);
    clients = await ClientService().getClientsFromFirebase();
    setIsloading(false);
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
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context, updated);
              },
            ),
          ),
          body: SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(children: [
                    const Center(
                      child: Text(
                        'Ajouter une vente',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                'Choisir un client',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                              ClientMenu(
                                value: clientValue,
                                clients: clients,
                                onChanged: (val) {
                                  setState(() {
                                    clientValue = val;
                                  });
                                },
                              ),
                            ],
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    Field(
                      hintText: 'quantite',
                      onChanged: (v) {
                        quantiteValue = int.parse(v);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DateButton(),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            elevation: 5),
                        onPressed: () async {
                          final String idp = widget.produit.idProduit;
                          final Vente vente = Vente(
                              idVente:
                                  'V${DateTime.now().toString().replaceAll('-', '').replaceAll(' ', '').replaceAll(':', '').substring(0, 14)}',
                              idClient: clientValue!,
                              idProduit: idp,
                              quantite: quantiteValue,
                              date: dateValue.toString());
                          await VenteService().setVenteToFirebase(vente: vente);
                          Navigator.pop(context, updated);
                        },
                        child: const Text(
                          'Envoyer',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ))
                  ]),
                ),
              ),
            ),
          )),
    );
  }

  Widget DateButton() {
    return ElevatedButton(
        onPressed: () {
          showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2022),
                  lastDate: DateTime(2030))
              .then((value) {
            dateValue = value!;
          });
        },
        child: const Text('Date'));
  }
}

class ClientMenu extends StatelessWidget {
  final List<Client> clients;
  final String? value;
  final Function? onChanged;
  const ClientMenu(
      {super.key, required this.clients, required this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton(
        elevation: 5,
        items: clients
            .map((e) => DropdownMenuItem(value: e.idClient, child: Text(e.nom)))
            .toList(),
        onChanged: (val) {
          onChanged!(val);
        },
        value: value,
      ),
    );
  }
}
