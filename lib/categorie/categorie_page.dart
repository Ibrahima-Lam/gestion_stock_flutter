import 'package:flutter/material.dart';
import 'package:gestion_stock_flutter/categorie/categorie.dart';
import 'package:gestion_stock_flutter/categorie/categorie_data.dart';
import 'package:gestion_stock_flutter/widget/drawer_widget.dart';

class CategoriePage extends StatefulWidget {
  const CategoriePage({super.key});

  @override
  State<CategoriePage> createState() => _CategoriePageState();
}

class _CategoriePageState extends State<CategoriePage> {
  final List<Categorie> categories = CategorieData().categories;
  final String appBarTitle = 'Listes des categories';

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
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            child: ListView(
              children: categories
                  .map((e) => ListTile(
                      leading: SizedBox(
                        width: 40,
                        height: 40,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Text(
                            e.nom.toUpperCase().substring(0, 2),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      title: Text(e.nom),
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                child: Center(child: Text(e.nom)),
                              );
                            });
                      }))
                  .toList(),
            ),
          ),
        )),
        drawer: const DrawerWidget(),
      ),
    );
  }
}
