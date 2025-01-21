import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gestion_stock_flutter/controllers/vente_controller.dart';
import 'package:gestion_stock_flutter/produit/produit.dart';
import 'package:gestion_stock_flutter/produit/produit_form_page.dart';
import 'package:gestion_stock_flutter/vente/vente_form_page.dart';
import 'package:get/get.dart';

class SingleProduit extends StatefulWidget {
  final Produit produit;

  const SingleProduit({super.key, required this.produit});

  @override
  State<SingleProduit> createState() => _SingleProduitState();
}

class _SingleProduitState extends State<SingleProduit> {
  final TextEditingController stockEditingController = TextEditingController();
  final VenteController _venteController = Get.put(VenteController());
  int vente = 0;
  bool isLoadingVente = false;

  void setIsloadingVente(bool val) {
    setState(() {
      isLoadingVente = val;
    });
  }

  @override
  void initState() {
    super.initState();
    _venteController.getVentes();
  }

  @override
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
        title: const Text('Les details du produit'),
      ),
      body: SafeArea(
          child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              widget.produit.image.isEmpty
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Text(
                          widget.produit.nom.toUpperCase().substring(0, 2),
                          style: const TextStyle(
                              fontSize: 60, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : CachedNetworkImage(
                      imageUrl: widget.produit.image,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Icon(Icons.image),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.image),
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      height: 200,
                      width: 200,
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
              Obx(
                () => Stack(
                  children: [
                    ItemRow(
                        title: 'Vente :',
                        content: _venteController
                            .getVenteTotalProduct(widget.produit.idProduit)
                            .toString()),
                    Center(
                      child: _venteController.isLoading.value
                          ? const CircularProgressIndicator(
                              color: Colors.black,
                            )
                          : null,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ActionButton(
                    title: ' Stocker',
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProduitForm(
                            produit: widget.produit,
                          ),
                        ),
                      );
                    },
                  ),
                  ActionButton(
                    title: 'Vendre',
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VenteForm(
                            produit: widget.produit,
                          ),
                        ),
                      );
                      _venteController.getVentes();
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
