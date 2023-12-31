import 'package:flutter/material.dart';
import 'package:gestion_stock_flutter/produit/produit.dart';
import 'package:gestion_stock_flutter/produit/produit_form_page.dart';
import 'package:gestion_stock_flutter/vente/vente_form_page.dart';

class SingleProduit extends StatefulWidget {
  final Produit produit;

  SingleProduit({super.key, required this.produit});

  @override
  State<SingleProduit> createState() => _SingleProduitState();
}

class _SingleProduitState extends State<SingleProduit> {
  final TextEditingController stockEditingController = TextEditingController();

  @override
  Future<void> neWPage() async {}
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Les details du produit'),
      ),
      body: SafeArea(
          child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              widget.produit.image.length == 0
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Text(
                          widget.produit.nom.toUpperCase().substring(0, 2),
                          style: TextStyle(
                              fontSize: 60, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : Container(
                      height: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget.produit.image))),
                    ),
              const SizedBox(
                height: 20,
              ),
              ItemRow(title: 'Nom du Produit :', content: widget.produit.nom),
              const SizedBox(
                height: 20,
              ),
              ItemRow(
                  title: 'Description :', content: widget.produit.description),
              const SizedBox(
                height: 20,
              ),
              ItemRow(title: 'Prix :', content: widget.produit.prix.toString()),
              const SizedBox(
                height: 20,
              ),
              ItemRow(
                  title: 'Stock :', content: widget.produit.stock.toString()),
              const SizedBox(
                height: 20,
              ),
              ItemRow(title: 'Vente :', content: ''),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ActionButton(
                    title: ' Stocker',
                    onPressed: () async {
                      dynamic a = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProduitForm(
                                    produit: widget.produit,
                                  )));
                      print('*' * 50);
                      print(a);
                    },
                  ),
                  ActionButton(
                    title: 'Vendre',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VenteForm(
                                    produit: widget.produit,
                                  )));
                    },
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String title;
  final Function onPressed;

  const ActionButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
        onPressed: () {
          onPressed();
        },
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ));
  }
}

class ItemRow extends StatelessWidget {
  const ItemRow({super.key, required this.title, required this.content});
  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            content,
            style: const TextStyle(
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}
