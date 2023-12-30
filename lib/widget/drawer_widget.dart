import 'package:flutter/material.dart';
import 'package:gestion_stock_flutter/categorie/categorie_page.dart';
import 'package:gestion_stock_flutter/client/client_page.dart';
import 'package:gestion_stock_flutter/home/login.dart';
import 'package:gestion_stock_flutter/produit/produit_page.dart';
import 'package:gestion_stock_flutter/vente/vente_page.dart';

class DrawerWidget extends StatelessWidget {
  final String titre = 'Gestion des Stock';
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: ListTile(
              leading: Icon(
                Icons.shop_2_rounded,
                size: 35,
              ),
              title: Text(
                titre,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () => Navigator.pop(context),
            ),
          ),
          ListTileWidget(
            texte: 'Produits',
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ProduitPage()));
            },
          ),
          ListTileWidget(
            texte: 'Categories',
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CategoriePage()));
            },
          ),
          ListTileWidget(
            texte: 'Ventes',
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => VentePage()));
            },
          ),
          ListTileWidget(
            texte: 'Clients',
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ClientPage()));
            },
          ),
          SizedBox(
            height: 50,
          ),
          ListTile(
            title: Text("Deconnexion"),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LoginPage())),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ListTileWidget extends StatelessWidget {
  final String texte;
  Function? onTap = null;

  ListTileWidget({super.key, this.onTap, required this.texte});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        texte,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap!();
      },
    );
  }
}
