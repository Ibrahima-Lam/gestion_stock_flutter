import 'package:flutter/material.dart';
import 'package:gestion_stock_flutter/produit/produit.dart';
import 'package:gestion_stock_flutter/produit/produit_page.dart';
import 'package:gestion_stock_flutter/service/produit_service.dart';
import 'package:gestion_stock_flutter/widget/default_field_widget.dart';

// ignore: must_be_immutable
class ProduitForm extends StatelessWidget {
  final TextEditingController stockEditingController = TextEditingController();
  int stock = 0;

  final Produit produit;
  ProduitForm({super.key, required this.produit});

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
              child: Container(
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
                      hintText: 'Quantite',
                      controller: stockEditingController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            elevation: 5),
                        onPressed: () async {
                          produit.stock = produit.stock +
                              (stockEditingController.text as int);
                          await ProduitService()
                              .setProduitToFirebase(produit: produit);
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

  Widget fields() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(20)),
      child: const TextField(
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(8),
            hintText: 'Quantité',
            border: InputBorder.none),
      ),
    );
  }
}
