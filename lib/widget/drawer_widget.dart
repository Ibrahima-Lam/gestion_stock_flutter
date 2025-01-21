import 'package:flutter/material.dart';
import 'package:gestion_stock_flutter/categorie/categorie_page.dart';
import 'package:gestion_stock_flutter/client/client_page.dart';
import 'package:gestion_stock_flutter/controllers/login_controller.dart';
import 'package:gestion_stock_flutter/produit/produit_page.dart';
import 'package:gestion_stock_flutter/vente/vente_page.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final String titre = 'Gestion des Stock';

  final LoginController _loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: ListTile(
              leading: const Icon(
                Icons.shop_2_rounded,
                size: 35,
              ),
              title: Text(
                titre,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () => Navigator.pop(context),
            ),
          ),
          ListTileWidget(
            texte: 'Produits',
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ProduitPage()));
            },
          ),
          ListTileWidget(
            texte: 'Categories',
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CategoriePage()));
            },
          ),
          ListTileWidget(
            texte: 'Ventes',
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const VentePage()));
            },
          ),
          ListTileWidget(
            texte: 'Clients',
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ClientPage()));
            },
          ),
          const SizedBox(
            height: 50,
          ),
          ListTile(
            title: const Text("Deconnexion"),
            onTap: () => _loginController.logout(context),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ListTileWidget extends StatelessWidget {
  final String texte;
  Function? onTap;

  ListTileWidget({super.key, this.onTap, required this.texte});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        texte,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap!();
      },
    );
  }
}
