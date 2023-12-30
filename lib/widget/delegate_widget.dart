import 'package:flutter/material.dart';
import 'package:gestion_stock_flutter/produit/produit.dart';
import 'package:gestion_stock_flutter/produit/single_produit.dart';

class Delegate extends SearchDelegate {
  final List<Produit> words;

  Delegate(
      {super.searchFieldLabel,
      super.searchFieldStyle,
      super.searchFieldDecorationTheme,
      super.keyboardType,
      super.textInputAction,
      required this.words});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      query.isEmpty
          ? Icon(Icons.mic)
          : IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          this.close(context, '');
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(this.query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.titleMedium!;
    final Iterable<Produit> suggestions = words.where(
        (element) => element.nom.toUpperCase().startsWith(query.toUpperCase()));
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        final Produit suggestion = suggestions.toList()[index];
        final String elementTitle = suggestion.nom;
        return ListTile(
            leading: suggestion.image.length == 0
                ? Container(
                    width: 40,
                    height: 40,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Text(
                        suggestion.nom.toUpperCase().substring(0, 2),
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                : Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(suggestion.image))),
                  ),
            title: RichText(
              text: TextSpan(
                  text: elementTitle.substring(0, query.length),
                  style: textTheme.copyWith(fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: elementTitle.substring(query.length),
                        style: textTheme)
                  ]),
            ),
            subtitle: Text(suggestion.prix.toString()),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SingleProduit(produit: suggestion)));
            });
      },
    );
  }
}
