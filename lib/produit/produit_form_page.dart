import 'package:flutter/material.dart';
import 'package:gestion_stock_flutter/produit/produit.dart';
import 'package:gestion_stock_flutter/service/produit_service.dart';

// ignore: must_be_immutable
class ProduitForm extends StatefulWidget {
  final Produit produit;
  const ProduitForm({super.key, required this.produit});

  @override
  State<ProduitForm> createState() => _ProduitFormState();
}

class _ProduitFormState extends State<ProduitForm> {
  int stock = 0;
  bool updated = false;

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
              child: Container(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(children: [
                    const Center(
                      child: Text(
                        'Ajouter un stock',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    fields(),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            elevation: 5),
                        onPressed: () async {
                          widget.produit.stock += stock;
                          await ProduitService()
                              .setProduitToFirebase(produit: widget.produit);
                          setState(() {
                            updated = true;
                          });
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

  Widget fields() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(20)),
      child: TextFormField(
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(8),
            hintText: 'Quantité',
            border: InputBorder.none),
        onChanged: (val) {
          setState(() {
            stock = int.parse(val);
          });
        },
      ),
    );
  }
}
