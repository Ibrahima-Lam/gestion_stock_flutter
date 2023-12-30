import 'package:flutter/material.dart';
import 'package:gestion_stock_flutter/produit/produit.dart';
import 'package:gestion_stock_flutter/produit/produit_page.dart';
import 'package:gestion_stock_flutter/widget/default_field_widget.dart';

class VenteForm extends StatelessWidget {
  final TextEditingController produitEditingController =
      TextEditingController();
  final TextEditingController clientEditingController = TextEditingController();
  final TextEditingController quantiteEditingController =
      TextEditingController();
  final TextEditingController dateEditingController = TextEditingController();

  final Produit produit;
  VenteForm({super.key, required this.produit});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(children: [
                    Center(
                      child: Text(
                        'Ajouter un stock',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Field(
                      hintText: 'produit',
                      controller: produitEditingController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Field(
                      hintText: 'client',
                      controller: clientEditingController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Field(
                      hintText: 'quantite',
                      controller: quantiteEditingController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DatePickerDialog(
                        onDatePickerModeChange: (e) {},
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2030)),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            elevation: 5),
                        onPressed: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProduitPage()));
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
}
